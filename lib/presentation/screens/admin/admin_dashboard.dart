import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:typed_data';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Modern Responsive Admin Dashboard with Animations
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _currentTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 800;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Modern Animated Header
              _buildAnimatedHeader(context),

              // Animated Tab Selector
              _buildTabSelector(),

              // Content
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWideScreen ? 800 : double.infinity,
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: const [_AddBookTab(), _AddEpisodeTab()],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Back Button with Glow
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Title with Hero Animation
            Expanded(
              child: Hero(
                tag: 'admin_title',
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [AppColors.primary, Color(0xFF8B5CF6)],
                        ).createShader(bounds),
                        child: Text(
                          'Admin Dashboard',
                          style: AppTypography.headlineSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage your audiobook library',
                        style: TextStyle(
                          color: AppColors.textTertiaryDark,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Stats Badge
            FadeInRight(
              delay: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            _buildTabButton(
              index: 0,
              icon: Icons.book_outlined,
              label: 'Add Book',
              gradient: const [Color(0xFF10B981), Color(0xFF059669)],
            ),
            _buildTabButton(
              index: 1,
              icon: Icons.playlist_add,
              label: 'Add Episode',
              gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required IconData icon,
    required String label,
    required List<Color> gradient,
  }) {
    final isSelected = _currentTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _tabController.animateTo(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isSelected ? LinearGradient(colors: gradient) : null,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: gradient[0].withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.textTertiaryDark,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textTertiaryDark,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== ADD BOOK TAB ====================
class _AddBookTab extends StatefulWidget {
  const _AddBookTab();

  @override
  State<_AddBookTab> createState() => _AddBookTabState();
}

class _AddBookTabState extends State<_AddBookTab> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _narratorController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _genreController = TextEditingController();
  final _languageController = TextEditingController();
  final _durationController = TextEditingController();
  final _ratingController = TextEditingController();

  Uint8List? _coverImageBytes;
  String? _coverImageName;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _narratorController.dispose();
    _synopsisController.dispose();
    _genreController.dispose();
    _languageController.dispose();
    _durationController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  Future<void> _pickCoverImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _coverImageBytes = result.files.first.bytes;
          _coverImageName = result.files.first.name;
        });
      }
    } catch (e) {
      _showError('Error picking image: $e');
    }
  }

  Future<void> _submitBook() async {
    if (!_formKey.currentState!.validate()) return;
    if (_coverImageBytes == null) {
      _showError('Please select a cover image');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final coverRef = _storage.ref().child(
        'covers/${DateTime.now().millisecondsSinceEpoch}_$_coverImageName',
      );
      final uploadTask = await coverRef.putData(
        _coverImageBytes!,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final coverUrl = await uploadTask.ref.getDownloadURL();

      await _firestore.collection('books').add({
        'title': _titleController.text.trim(),
        'author': _authorController.text.trim(),
        'narrator': _narratorController.text.trim(),
        'synopsis': _synopsisController.text.trim(),
        'genre': _genreController.text.trim(),
        'language': _languageController.text.trim().isEmpty
            ? 'English'
            : _languageController.text.trim(),
        'coverUrl': coverUrl,
        'durationSeconds': int.tryParse(_durationController.text) ?? 0,
        'rating': double.tryParse(_ratingController.text) ?? 0.0,
        'episodeCount': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        _showSuccess('Book added successfully! 🎉');
        _clearForm();
      }
    } catch (e) {
      _showError('Error adding book: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearForm() {
    _titleController.clear();
    _authorController.clear();
    _narratorController.clear();
    _synopsisController.clear();
    _genreController.clear();
    _languageController.clear();
    _durationController.clear();
    _ratingController.clear();
    setState(() {
      _coverImageBytes = null;
      _coverImageName = null;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Cover Image Picker with Animation
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: _buildCoverImagePicker(),
            ),
            const SizedBox(height: 24),

            // Form Fields with Staggered Animation
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _buildModernTextField(
                controller: _titleController,
                label: 'Book Title',
                icon: Icons.book,
                gradient: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
            ),
            const SizedBox(height: 16),

            FadeInUp(
              delay: const Duration(milliseconds: 250),
              child: _buildModernTextField(
                controller: _authorController,
                label: 'Author',
                icon: Icons.person,
                gradient: const [Color(0xFF10B981), Color(0xFF059669)],
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
            ),
            const SizedBox(height: 16),

            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: _buildModernTextField(
                controller: _narratorController,
                label: 'Narrator',
                icon: Icons.record_voice_over,
                gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
              ),
            ),
            const SizedBox(height: 16),

            FadeInUp(
              delay: const Duration(milliseconds: 350),
              child: _buildModernTextField(
                controller: _synopsisController,
                label: 'Synopsis',
                icon: Icons.description,
                gradient: const [Color(0xFFEC4899), Color(0xFFDB2777)],
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),

            // Row for Genre and Language
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Row(
                children: [
                  Expanded(
                    child: _buildModernTextField(
                      controller: _genreController,
                      label: 'Genre',
                      icon: Icons.category,
                      gradient: const [Color(0xFF3B82F6), Color(0xFF2563EB)],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildModernTextField(
                      controller: _languageController,
                      label: 'Language',
                      icon: Icons.language,
                      gradient: const [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Row for Duration and Rating
            FadeInUp(
              delay: const Duration(milliseconds: 450),
              child: Row(
                children: [
                  Expanded(
                    child: _buildModernTextField(
                      controller: _durationController,
                      label: 'Duration (sec)',
                      icon: Icons.timer,
                      gradient: const [Color(0xFF14B8A6), Color(0xFF0D9488)],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildModernTextField(
                      controller: _ratingController,
                      label: 'Rating (0-5)',
                      icon: Icons.star,
                      gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button with Glow
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: _buildSubmitButton(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImagePicker() {
    return GestureDetector(
      onTap: _pickCoverImage,
      child: Hero(
        tag: 'cover_picker',
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.05),
                Colors.white.withValues(alpha: 0.02),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _coverImageBytes != null
                  ? AppColors.success
                  : Colors.white.withValues(alpha: 0.1),
              width: 2,
            ),
            boxShadow: _coverImageBytes != null
                ? [
                    BoxShadow(
                      color: AppColors.success.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: _coverImageBytes != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.memory(
                        _coverImageBytes!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap to upload cover image',
                      style: TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'JPG, PNG up to 5MB',
                      style: TextStyle(
                        color: AppColors.textTertiaryDark,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required List<Color> gradient,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.textSecondaryDark),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: gradient[0], width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _submitBook,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_circle_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Add Book',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ==================== ADD EPISODE TAB ====================
class _AddEpisodeTab extends StatefulWidget {
  const _AddEpisodeTab();

  @override
  State<_AddEpisodeTab> createState() => _AddEpisodeTabState();
}

class _AddEpisodeTabState extends State<_AddEpisodeTab> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();

  String? _selectedBookId;
  String? _selectedBookTitle;
  String? _selectedBookCover;
  int _nextSequence = 1;
  Uint8List? _audioFileBytes;
  String? _audioFileName;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _selectBook() async {
    final booksSnapshot = await _firestore.collection('books').get();
    final books = booksSnapshot.docs;

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.library_books, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Select Book',
                    style: AppTypography.titleLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  final data = book.data();
                  return FadeInUp(
                    delay: Duration(milliseconds: 50 * index),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await _onBookSelected(
                          book.id,
                          data['title'],
                          data['coverUrl'],
                          data['episodeCount'] ?? 0,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                data['coverUrl'] ?? '',
                                width: 50,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 50,
                                  height: 70,
                                  color: AppColors.cardDark,
                                  child: const Icon(
                                    Icons.book,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['title'] ?? 'Untitled',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['author'] ?? 'Unknown',
                                    style: TextStyle(
                                      color: AppColors.textTertiaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${data['episodeCount'] ?? 0} eps',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onBookSelected(
    String bookId,
    String title,
    String? cover,
    int episodeCount,
  ) async {
    setState(() {
      _selectedBookId = bookId;
      _selectedBookTitle = title;
      _selectedBookCover = cover;
      _nextSequence = episodeCount + 1;
    });
  }

  Future<void> _pickAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _audioFileBytes = result.files.first.bytes;
          _audioFileName = result.files.first.name;
        });
      }
    } catch (e) {
      _showError('Error picking audio: $e');
    }
  }

  Future<void> _submitEpisode() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBookId == null) {
      _showError('Please select a book first');
      return;
    }
    if (_audioFileBytes == null) {
      _showError('Please select an audio file');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final audioRef = _storage.ref().child(
        'audio/$_selectedBookId/${DateTime.now().millisecondsSinceEpoch}_$_audioFileName',
      );
      final uploadTask = await audioRef.putData(
        _audioFileBytes!,
        SettableMetadata(contentType: 'audio/mpeg'),
      );
      final audioUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('books')
          .doc(_selectedBookId)
          .collection('episodes')
          .add({
            'bookId': _selectedBookId,
            'title': _titleController.text.trim().isEmpty
                ? 'Chapter $_nextSequence'
                : _titleController.text.trim(),
            'sequence': _nextSequence,
            'audioUrl': audioUrl,
            'durationSeconds': int.tryParse(_durationController.text) ?? 0,
            'createdAt': FieldValue.serverTimestamp(),
          });

      await _firestore.collection('books').doc(_selectedBookId).update({
        'episodeCount': FieldValue.increment(1),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        _showSuccess('Episode #$_nextSequence added! 🎉');
        _clearEpisodeForm();
      }
    } catch (e) {
      _showError('Error adding episode: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearEpisodeForm() {
    _titleController.clear();
    _durationController.clear();
    setState(() {
      _audioFileBytes = null;
      _audioFileName = null;
      _nextSequence++;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Book Selector with Hero Animation
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: _buildBookSelector(),
            ),
            const SizedBox(height: 24),

            // Auto-Sequence Display
            if (_selectedBookId != null)
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        const Color(0xFFD97706).withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.format_list_numbered,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Next Episode: #$_nextSequence',
                        style: AppTypography.titleMedium.copyWith(
                          color: const Color(0xFFF59E0B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Episode Title
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: _buildModernTextField(
                controller: _titleController,
                label: 'Episode Title (optional)',
                icon: Icons.title,
                gradient: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
            ),
            const SizedBox(height: 16),

            // Audio File Picker
            FadeInUp(
              delay: const Duration(milliseconds: 350),
              child: _buildAudioPicker(),
            ),
            const SizedBox(height: 16),

            // Duration
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _buildModernTextField(
                controller: _durationController,
                label: 'Duration (seconds)',
                icon: Icons.timer,
                gradient: const [Color(0xFF14B8A6), Color(0xFF0D9488)],
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            FadeInUp(
              delay: const Duration(milliseconds: 450),
              child: _buildSubmitButton(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBookSelector() {
    return GestureDetector(
      onTap: _selectBook,
      child: Hero(
        tag: 'book_selector',
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.05),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _selectedBookId != null
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.1),
              width: 2,
            ),
            boxShadow: _selectedBookId != null
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              if (_selectedBookCover != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    _selectedBookCover!,
                    width: 50,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.menu_book, color: Colors.white),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedBookTitle ?? 'Select a Book',
                      style: TextStyle(
                        color: _selectedBookId != null
                            ? Colors.white
                            : AppColors.textSecondaryDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (_selectedBookId != null)
                      Text(
                        'Tap to change',
                        style: TextStyle(
                          color: AppColors.textTertiaryDark,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textTertiaryDark,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPicker() {
    return GestureDetector(
      onTap: _pickAudioFile,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.05),
              Colors.white.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _audioFileBytes != null
                ? AppColors.success
                : Colors.white.withValues(alpha: 0.1),
            width: 2,
          ),
          boxShadow: _audioFileBytes != null
              ? [
                  BoxShadow(
                    color: AppColors.success.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _audioFileBytes != null
                      ? [AppColors.success, const Color(0xFF059669)]
                      : [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _audioFileBytes != null ? Icons.audio_file : Icons.upload_file,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _audioFileName ?? 'Tap to upload audio',
                    style: TextStyle(
                      color: _audioFileBytes != null
                          ? AppColors.success
                          : AppColors.textSecondaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_audioFileBytes == null)
                    Text(
                      'MP3, M4A, WAV supported',
                      style: TextStyle(
                        color: AppColors.textTertiaryDark,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required List<Color> gradient,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.textSecondaryDark),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: gradient[0], width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _submitEpisode,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.playlist_add, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Add Episode #$_nextSequence',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
