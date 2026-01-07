// =============================================================================
// MAIN SHELL - App Shell with Bottom Navigation
// =============================================================================
// The main authenticated app shell containing:
// - Bottom navigation bar (5 tabs)
// - Mini player overlay
// - Screen stack for each tab
//
// NAVIGATION RELATIONSHIPS:
// - From: Login Screen (after auth) or Preferences Screen (after signup)
// - Contains: Home, Search, Library, Social, Account tabs
// - Dependencies: neu_bottom_nav.dart, all tab screens
// =============================================================================

import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/constants/spacing.dart';
import '../core/theme/neumorphism/neumorphic_styles.dart';

// Tab screens
import 'home/screens/home_screen.dart';
import 'home/screens/discover_screen.dart';
import 'search/screens/search_screen.dart';
import 'library/screens/library_screen.dart';
import 'social/screens/social_hub_screen.dart';
import 'profile/screens/profile_screen.dart';

// Widgets
import 'player/widgets/mini_player.dart';

/// Main app shell with bottom navigation.
///
/// Contains 5 main tabs:
/// 1. Home - Dashboard and recommendations
/// 2. Search - Discover and search books
/// 3. Library - User's book collection
/// 4. Social - Community and book clubs
/// 5. Account - User profile and settings
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Tab navigation items
  final List<_NavItem> _navItems = [
    _NavItem(Icons.home_outlined, Icons.home_rounded, 'Home'),
    _NavItem(Icons.search_outlined, Icons.search_rounded, 'Search'),
    _NavItem(
      Icons.library_books_outlined,
      Icons.library_books_rounded,
      'Library',
    ),
    _NavItem(Icons.people_outline, Icons.people_rounded, 'Social'),
    _NavItem(Icons.person_outline, Icons.person_rounded, 'Account'),
  ];

  // Tab screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
    const SocialHubScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _screens),
          ),
          const MiniPlayer(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  /// Build neumorphic bottom navigation bar
  Widget _buildBottomNav(bool isDark) {
    return Container(
      height: Spacing.bottomNavHeight + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        boxShadow: [
          BoxShadow(
            color:
                (isDark ? AppColors.darkShadowDark : AppColors.darkShadowLight)
                    .withValues(alpha: 0.1),
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (index) {
          return _buildNavItem(index, isDark);
        }),
      ),
    );
  }

  /// Build individual nav item
  Widget _buildNavItem(int index, bool isDark) {
    final item = _navItems[index];
    final isSelected = index == _currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with neumorphic effect when selected
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(Spacing.sm),
                decoration: isSelected
                    ? NeuDecoration.pressed(
                        radius: Spacing.radiusMd,
                        intensity: NeuIntensity.light,
                        isDark: isDark,
                      )
                    : const BoxDecoration(),
                child: Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  size: 24,
                  color: isSelected ? AppColors.primary : AppColors.iconDefault,
                ),
              ),
              const SizedBox(height: 2),

              // Label
              Text(
                item.label,
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Data class for navigation items
class _NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  _NavItem(this.icon, this.selectedIcon, this.label);
}
