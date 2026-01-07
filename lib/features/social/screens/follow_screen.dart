// =============================================================================
// FOLLOW SCREEN - Social Connections
// =============================================================================
// DESIGN: 60% Neumorphism + 30% Solid Glow + 10% Flat Elements
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key});

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(),
            const SizedBox(height: Spacing.md),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildFollowingTab(), _buildFollowersTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 6,
                    offset: Offset(-3, -3),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadowLight.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back, size: 20),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Connections', style: AppTypography.h4),
              Text(
                'Your reading community',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Icon(Icons.person_add, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.pressed,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.textHint, size: 20),
            const SizedBox(width: Spacing.sm),
            Text(
              'Search connections...',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 6,
            offset: Offset(-3, -3),
          ),
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: 'Following (142)'),
          Tab(text: 'Followers (89)'),
        ],
      ),
    );
  }

  Widget _buildFollowingTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      children: [
        Text(
          'SUGGESTED FOR YOU',
          style: AppTypography.overline.copyWith(
            color: AppColors.textHint,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: Spacing.md),
        _buildSuggestionsRow(),
        const SizedBox(height: Spacing.xl),
        Text(
          'FOLLOWING',
          style: AppTypography.overline.copyWith(
            color: AppColors.textHint,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: Spacing.md),
        _buildUserTile(
          'Sarah Mitchell',
          '@bookworm_sarah',
          '1.2k books',
          Colors.purple,
          true,
          true,
        ),
        _buildUserTile(
          'Alex Chen',
          '@alexreads',
          '890 books',
          Colors.blue,
          true,
          false,
        ),
        _buildUserTile(
          'Emma Watson',
          '@emma_listens',
          '456 books',
          Colors.pink,
          true,
          false,
        ),
        _buildUserTile(
          'Mike Johnson',
          '@mikereads',
          '234 books',
          Colors.green,
          true,
          false,
        ),
      ],
    );
  }

  Widget _buildFollowersTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      children: [
        _buildUserTile(
          'John Doe',
          '@johndoe',
          '234 books',
          Colors.orange,
          false,
          false,
        ),
        _buildUserTile(
          'Jane Smith',
          '@janesmith',
          '567 books',
          Colors.teal,
          true,
          false,
        ),
        _buildUserTile(
          'Mike Johnson',
          '@mikej',
          '123 books',
          Colors.indigo,
          false,
          false,
        ),
        _buildUserTile(
          'Lisa Brown',
          '@lisab',
          '89 books',
          Colors.red,
          false,
          false,
        ),
      ],
    );
  }

  Widget _buildSuggestionsRow() {
    final suggestions = [
      {
        'name': 'Book Club Admin',
        'mutual': '12 mutual',
        'color': Colors.purple,
      },
      {'name': 'AudioNerd', 'mutual': '8 mutual', 'color': Colors.blue},
      {'name': 'LitFan2024', 'mutual': '5 mutual', 'color': Colors.teal},
    ];

    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final user = suggestions[index];
          final color = user['color'] as Color;
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: Spacing.md),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusMd,
              padding: const EdgeInsets.all(Spacing.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withValues(alpha: 0.4), color],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [GlowStyles.colorGlowSubtle(color)],
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: Spacing.sm),
                  Text(
                    user['name'] as String,
                    style: AppTypography.labelSmall,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    user['mutual'] as String,
                    style: AppTypography.overline.copyWith(
                      color: AppColors.textHint,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: Spacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                      boxShadow: [GlowStyles.primaryGlowSubtle],
                    ),
                    child: Center(
                      child: Text(
                        'Follow',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserTile(
    String name,
    String handle,
    String books,
    Color color,
    bool isFollowing,
    bool isOnline,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.sm),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.3),
                        color.withValues(alpha: 0.6),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [GlowStyles.colorGlowSubtle(color)],
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 26),
                ),
                if (isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.backgroundLight,
                          width: 2,
                        ),
                        boxShadow: [GlowStyles.colorGlowSubtle(Colors.green)],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.labelMedium),
                  Text(
                    handle,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book,
                        size: 12,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        books,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
              decoration: BoxDecoration(
                color: isFollowing
                    ? AppColors.backgroundLight
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
                border: isFollowing
                    ? Border.all(color: AppColors.border)
                    : null,
                boxShadow: isFollowing
                    ? [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.8),
                          blurRadius: 4,
                          offset: Offset(-2, -2),
                        ),
                        BoxShadow(
                          color: AppColors.darkShadowLight.withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ]
                    : [GlowStyles.primaryGlowSubtle],
              ),
              child: Text(
                isFollowing ? 'Following' : 'Follow',
                style: AppTypography.labelSmall.copyWith(
                  color: isFollowing ? AppColors.textSecondary : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
