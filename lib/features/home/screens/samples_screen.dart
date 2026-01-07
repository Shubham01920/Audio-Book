// =============================================================================
// SAMPLES SCREEN - Audio Trailers Feed (Page 8)
// =============================================================================
// TikTok-style vertical feed of audiobook samples/trailers.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Home (Tab 1), Discover
// - To: Player Screen (full book), Book Detail
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

class SamplesScreen extends StatefulWidget {
  const SamplesScreen({super.key});

  @override
  State<SamplesScreen> createState() => _SamplesScreenState();
}

class _SamplesScreenState extends State<SamplesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _samples = [
    {
      'title': 'Project Hail Mary',
      'author': 'Andy Weir',
      'narrator': 'Ray Porter',
      'color': const Color(0xFF2D3748),
      'accent': Colors.blue,
      'quote': '"I\'m a scary space monster. You\'re a leaky space blob."',
      'likes': '12.4k',
      'duration': '5:30',
    },
    {
      'title': 'The Psychology of Money',
      'author': 'Morgan Housel',
      'narrator': 'Chris Hill',
      'color': const Color(0xFF1A365D),
      'accent': Colors.teal,
      'quote':
          'Spending money to show people how much money you have is the fastest way to have less money.',
      'likes': '8.7k',
      'duration': '4:15',
    },
    {
      'title': 'Greenlights',
      'author': 'Matthew McConaughey',
      'narrator': 'Matthew McConaughey',
      'color': const Color(0xFF744210),
      'accent': Colors.orange,
      'quote': 'The arrows don\'t accidentally land in the bullseye.',
      'likes': '15.2k',
      'duration': '6:00',
    },
    {
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'narrator': 'James Clear',
      'color': const Color(0xFF553C9A),
      'accent': Colors.purple,
      'quote':
          'You do not rise to the level of your goals. You fall to the level of your systems.',
      'likes': '24.1k',
      'duration': '4:45',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.sm,
                vertical: Spacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [GlowStyles.primaryGlowSubtle],
              ),
              child: Row(
                children: [
                  const Icon(Icons.play_circle, size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    'Samples',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: _samples.length,
        itemBuilder: (context, index) {
          return _buildSampleCard(_samples[index], index == _currentPage);
        },
      ),
    );
  }

  Widget _buildSampleCard(Map<String, dynamic> sample, bool isActive) {
    final accentColor = sample['accent'] as Color;

    return Stack(
      children: [
        // Background gradient
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                sample['color'],
                (sample['color'] as Color).withValues(alpha: 0.8),
                Colors.black,
              ],
            ),
          ),
        ),

        // Animated visualizer placeholder
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quote with glow effect
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Spacing.xl),
                padding: const EdgeInsets.all(Spacing.lg),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(Spacing.radiusLg),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  sample['quote'],
                  textAlign: TextAlign.center,
                  style: AppTypography.h4.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.xl),

              // Waveform with glow
              _buildWaveform(accentColor),
            ],
          ),
        ),

        // Side actions
        Positioned(
          right: Spacing.screenHorizontal,
          bottom: 200,
          child: _buildSideActions(sample, accentColor),
        ),

        // Bottom info & controls
        Positioned(
          left: 0,
          right: 70,
          bottom: Spacing.xxl + 30,
          child: _buildBottomInfo(sample, accentColor),
        ),

        // Progress indicator
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildProgressBar(accentColor),
        ),
      ],
    );
  }

  Widget _buildWaveform(Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          25,
          (i) => AnimatedContainer(
            duration: Duration(milliseconds: 200 + (i * 50)),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 4,
            height: 15.0 + ((i % 7) * 8),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.5),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSideActions(Map<String, dynamic> sample, Color accentColor) {
    return Column(
      children: [
        // Like button with glow
        _buildActionButton(Icons.favorite_border, sample['likes'], Colors.pink),
        const SizedBox(height: Spacing.lg),

        // Comment
        _buildActionButton(Icons.chat_bubble_outline, '234', Colors.white),
        const SizedBox(height: Spacing.lg),

        // Share
        _buildActionButton(Icons.share, 'Share', Colors.white),
        const SizedBox(height: Spacing.lg),

        // Add to library
        _buildActionButton(Icons.add_circle_outline, 'Save', accentColor),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
              boxShadow: [GlowStyles.colorGlowSubtle(color)],
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfo(Map<String, dynamic> sample, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with glow
          Text(
            sample['title'],
            style: AppTypography.h2.copyWith(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: accentColor.withValues(alpha: 0.5),
                  blurRadius: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            'by ${sample['author']}',
            style: AppTypography.bodyMedium.copyWith(color: Colors.white70),
          ),
          Text(
            'Narrated by ${sample['narrator']}',
            style: AppTypography.caption.copyWith(color: Colors.white54),
          ),
          const SizedBox(height: Spacing.md),

          // CTA Button with glow
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
              boxShadow: [GlowStyles.colorGlow(accentColor)],
            ),
            child: NeuButton(
              text: 'Listen Full Book',
              onPressed: () => Navigator.pushNamed(context, Routes.player),
              variant: NeuButtonVariant.primary,
              textColor: Colors.white,
              backgroundColor: accentColor,
              fullWidth: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(Color accentColor) {
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: 0.35,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentColor, accentColor.withValues(alpha: 0.7)],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [GlowStyles.colorGlowSubtle(accentColor)],
          ),
        ),
      ),
    );
  }
}
