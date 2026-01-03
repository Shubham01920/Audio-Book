import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/extensions.dart';

/// Custom progress bar widget for audio player
class PlayerProgressBar extends StatefulWidget {
  final Duration position;
  final Duration? duration;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onSeek;
  final bool showTime;
  final double height;

  const PlayerProgressBar({
    super.key,
    required this.position,
    this.duration,
    required this.bufferedPosition,
    this.onSeek,
    this.showTime = true,
    this.height = 4.0,
  });

  @override
  State<PlayerProgressBar> createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends State<PlayerProgressBar> {
  double? _dragValue;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final total = widget.duration ?? Duration.zero;
    final position = _isDragging
        ? Duration(milliseconds: (_dragValue! * total.inMilliseconds).round())
        : widget.position;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress bar
        GestureDetector(
          onHorizontalDragStart: (details) {
            setState(() {
              _isDragging = true;
              _updateDragPosition(details.localPosition.dx, context);
            });
          },
          onHorizontalDragUpdate: (details) {
            _updateDragPosition(details.localPosition.dx, context);
          },
          onHorizontalDragEnd: (details) {
            if (_dragValue != null && widget.duration != null) {
              final newPosition = Duration(
                milliseconds: (_dragValue! * widget.duration!.inMilliseconds)
                    .round(),
              );
              widget.onSeek?.call(newPosition);
            }
            setState(() {
              _isDragging = false;
              _dragValue = null;
            });
          },
          onTapDown: (details) {
            _updateDragPosition(details.localPosition.dx, context);
            if (_dragValue != null && widget.duration != null) {
              final newPosition = Duration(
                milliseconds: (_dragValue! * widget.duration!.inMilliseconds)
                    .round(),
              );
              widget.onSeek?.call(newPosition);
            }
            _dragValue = null;
          },
          child: Container(
            height: 44, // Touch target
            alignment: Alignment.center,
            child: SizedBox(
              height: widget.height,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final progressValue = _isDragging
                      ? _dragValue ?? 0.0
                      : (total.inMilliseconds > 0
                            ? widget.position.inMilliseconds /
                                  total.inMilliseconds
                            : 0.0);
                  final bufferedValue = total.inMilliseconds > 0
                      ? widget.bufferedPosition.inMilliseconds /
                            total.inMilliseconds
                      : 0.0;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Background track
                      Container(
                        width: width,
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: AppColors.progressInactive,
                          borderRadius: BorderRadius.circular(
                            widget.height / 2,
                          ),
                        ),
                      ),
                      // Buffered track
                      Container(
                        width: width * bufferedValue.clamp(0.0, 1.0),
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: AppColors.progressBuffer,
                          borderRadius: BorderRadius.circular(
                            widget.height / 2,
                          ),
                        ),
                      ),
                      // Progress track
                      Container(
                        width: width * progressValue.clamp(0.0, 1.0),
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            widget.height / 2,
                          ),
                        ),
                      ),
                      // Thumb
                      Positioned(
                        left: (width * progressValue.clamp(0.0, 1.0)) - 8,
                        top: (widget.height - 16) / 2,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: _isDragging ? 20 : 16,
                          height: _isDragging ? 20 : 16,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: _isDragging
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),

        // Time labels
        if (widget.showTime)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  position.toFormattedString(),
                  style: AppTypography.playerTime.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
                Text(
                  widget.duration?.toFormattedString() ?? '--:--',
                  style: AppTypography.playerTime.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _updateDragPosition(double localX, BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final width = box.size.width;
      setState(() {
        _dragValue = (localX / width).clamp(0.0, 1.0);
      });
    }
  }
}
