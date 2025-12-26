import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/episode_model.dart';

/// Download status for an episode
enum DownloadStatus { notDownloaded, downloading, paused, completed, failed }

/// Download info for an episode
class DownloadInfo {
  final String episodeId;
  final String bookId;
  final DownloadStatus status;
  final double progress;
  final String? localPath;
  final String? error;

  const DownloadInfo({
    required this.episodeId,
    required this.bookId,
    required this.status,
    this.progress = 0.0,
    this.localPath,
    this.error,
  });

  DownloadInfo copyWith({
    DownloadStatus? status,
    double? progress,
    String? localPath,
    String? error,
  }) {
    return DownloadInfo(
      episodeId: episodeId,
      bookId: bookId,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      localPath: localPath ?? this.localPath,
      error: error ?? this.error,
    );
  }
}

/// Manages offline downloads for audiobook episodes
class DownloadManager extends ChangeNotifier {
  static const String _boxName = 'downloads';

  Box? _downloadsBox;
  final Map<String, DownloadInfo> _downloads = {};
  final Map<String, StreamSubscription> _activeDownloads = {};

  /// All current downloads
  Map<String, DownloadInfo> get downloads => Map.unmodifiable(_downloads);

  /// Initialize download manager
  Future<void> init() async {
    _downloadsBox = await Hive.openBox(_boxName);
    await _loadDownloadsFromStorage();
  }

  /// Load saved download info from Hive
  Future<void> _loadDownloadsFromStorage() async {
    if (_downloadsBox == null) return;

    for (final key in _downloadsBox!.keys) {
      final data = _downloadsBox!.get(key) as Map<dynamic, dynamic>?;
      if (data != null) {
        _downloads[key as String] = DownloadInfo(
          episodeId: data['episodeId'] ?? key,
          bookId: data['bookId'] ?? '',
          status: DownloadStatus.values.firstWhere(
            (s) => s.name == data['status'],
            orElse: () => DownloadStatus.notDownloaded,
          ),
          progress: (data['progress'] as num?)?.toDouble() ?? 0.0,
          localPath: data['localPath'],
        );
      }
    }
    notifyListeners();
  }

  /// Get downloads directory
  Future<Directory> get _downloadsDirectory async {
    final appDir = await getApplicationDocumentsDirectory();
    final downloadsDir = Directory('${appDir.path}/audiobooks');
    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }
    return downloadsDir;
  }

  // ==================== DOWNLOAD OPERATIONS ====================

  /// Download a single episode
  Future<void> downloadEpisode(Episode episode) async {
    if (_downloads[episode.id]?.status == DownloadStatus.downloading) {
      return; // Already downloading
    }

    // Update status to downloading
    _updateDownloadInfo(
      episode.id,
      DownloadInfo(
        episodeId: episode.id,
        bookId: episode.bookId,
        status: DownloadStatus.downloading,
        progress: 0.0,
      ),
    );

    try {
      final dir = await _downloadsDirectory;
      final fileName = '${episode.bookId}_${episode.id}.mp3';
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // Start download
      final request = http.Request('GET', Uri.parse(episode.audioUrl));
      final response = await http.Client().send(request);

      if (response.statusCode != 200) {
        throw Exception('Failed to download: ${response.statusCode}');
      }

      final contentLength = response.contentLength ?? 0;
      int receivedBytes = 0;

      final sink = file.openWrite();

      await for (final chunk in response.stream) {
        sink.add(chunk);
        receivedBytes += chunk.length;

        if (contentLength > 0) {
          final progress = receivedBytes / contentLength;
          _updateDownloadInfo(
            episode.id,
            _downloads[episode.id]!.copyWith(progress: progress),
          );
        }
      }

      await sink.close();

      // Update status to completed
      _updateDownloadInfo(
        episode.id,
        _downloads[episode.id]!.copyWith(
          status: DownloadStatus.completed,
          progress: 1.0,
          localPath: filePath,
        ),
      );
    } catch (e) {
      print("Download error: $e");
      _updateDownloadInfo(
        episode.id,
        _downloads[episode.id]!.copyWith(
          status: DownloadStatus.failed,
          error: e.toString(),
        ),
      );
    }
  }

  /// Download all episodes of a book
  Future<void> downloadBook(String bookId, List<Episode> episodes) async {
    for (final episode in episodes) {
      await downloadEpisode(episode);
    }
  }

  /// Cancel an active download
  Future<void> cancelDownload(String episodeId) async {
    _activeDownloads[episodeId]?.cancel();
    _activeDownloads.remove(episodeId);

    if (_downloads.containsKey(episodeId)) {
      _updateDownloadInfo(
        episodeId,
        _downloads[episodeId]!.copyWith(
          status: DownloadStatus.notDownloaded,
          progress: 0.0,
        ),
      );
    }
  }

  /// Delete a downloaded episode
  Future<void> deleteDownload(String episodeId) async {
    final info = _downloads[episodeId];
    if (info?.localPath != null) {
      try {
        final file = File(info!.localPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print("Error deleting file: $e");
      }
    }

    _downloads.remove(episodeId);
    await _downloadsBox?.delete(episodeId);
    notifyListeners();
  }

  /// Delete all downloads for a book
  Future<void> deleteBookDownloads(String bookId) async {
    final toDelete = _downloads.entries
        .where((e) => e.value.bookId == bookId)
        .map((e) => e.key)
        .toList();

    for (final episodeId in toDelete) {
      await deleteDownload(episodeId);
    }
  }

  // ==================== QUERY METHODS ====================

  /// Check if an episode is downloaded
  bool isDownloaded(String episodeId) {
    return _downloads[episodeId]?.status == DownloadStatus.completed;
  }

  /// Check if an episode is currently downloading
  bool isDownloading(String episodeId) {
    return _downloads[episodeId]?.status == DownloadStatus.downloading;
  }

  /// Get download progress for an episode (0.0 to 1.0)
  double getDownloadProgress(String episodeId) {
    return _downloads[episodeId]?.progress ?? 0.0;
  }

  /// Get local file path for an episode
  String? getLocalPath(String episodeId) {
    return _downloads[episodeId]?.localPath;
  }

  /// Get download status for an episode
  DownloadStatus getDownloadStatus(String episodeId) {
    return _downloads[episodeId]?.status ?? DownloadStatus.notDownloaded;
  }

  /// Get all downloaded episodes for a book
  List<String> getDownloadedEpisodeIds(String bookId) {
    return _downloads.entries
        .where(
          (e) =>
              e.value.bookId == bookId &&
              e.value.status == DownloadStatus.completed,
        )
        .map((e) => e.key)
        .toList();
  }

  /// Get total download storage size in bytes
  Future<int> getTotalDownloadSize() async {
    int totalSize = 0;
    for (final info in _downloads.values) {
      if (info.localPath != null) {
        try {
          final file = File(info.localPath!);
          if (await file.exists()) {
            totalSize += await file.length();
          }
        } catch (e) {
          // Ignore
        }
      }
    }
    return totalSize;
  }

  /// Clear all downloads
  Future<void> clearAllDownloads() async {
    for (final episodeId in _downloads.keys.toList()) {
      await deleteDownload(episodeId);
    }
  }

  // ==================== PRIVATE METHODS ====================

  void _updateDownloadInfo(String episodeId, DownloadInfo info) {
    _downloads[episodeId] = info;
    _saveDownloadToStorage(episodeId, info);
    notifyListeners();
  }

  Future<void> _saveDownloadToStorage(
    String episodeId,
    DownloadInfo info,
  ) async {
    await _downloadsBox?.put(episodeId, {
      'episodeId': info.episodeId,
      'bookId': info.bookId,
      'status': info.status.name,
      'progress': info.progress,
      'localPath': info.localPath,
    });
  }
}
