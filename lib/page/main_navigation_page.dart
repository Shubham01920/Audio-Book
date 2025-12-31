import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../features/player/provider/player_provider.dart';
import '../features/player/widgets/mini_player.dart';
import 'home_page.dart';
import 'discover_page.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

/// Main navigation wrapper with premium animated bottom nav
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const DiscoverPage(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  final List<_NavItemData> _navItems = [
    _NavItemData(Icons.home_outlined, Icons.home_rounded, 'Home'),
    _NavItemData(Icons.explore_outlined, Icons.explore_rounded, 'Discover'),
    _NavItemData(Icons.search_outlined, Icons.search_rounded, 'Search'),
    _NavItemData(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _pages),
          ),
          // Mini player
          Consumer<PlayerProvider>(
            builder: (context, playerProvider, child) {
              if (!playerProvider.state.hasContent) {
                return const SizedBox.shrink();
              }
              return const MiniPlayer();
            },
          ),
        ],
      ),
      bottomNavigationBar: _PremiumBottomNav(
        currentIndex: _currentIndex,
        items: _navItems,
        isDark: isDark,
        onTap: (index) {
          HapticFeedback.lightImpact();
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  _NavItemData(this.icon, this.activeIcon, this.label);
}

/// Industry-level premium bottom navigation with liquid glass effect
class _PremiumBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavItemData> items;
  final bool isDark;
  final ValueChanged<int> onTap;

  const _PremiumBottomNav({
    required this.currentIndex,
    required this.items,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            // Liquid glass effect with transparency
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      Colors.white.withValues(alpha: 0.08),
                      Colors.white.withValues(alpha: 0.05),
                    ]
                  : [
                      AppColors.primary.withValues(alpha: 0.85),
                      AppColors.primaryDark.withValues(alpha: 0.9),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            // Glass border shine effect
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.white.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
            boxShadow: [
              // Outer glow
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.5)
                    : AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 25,
                offset: const Offset(0, -8),
                spreadRadius: -5,
              ),
              // Inner subtle shadow for depth
              BoxShadow(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  return _AnimatedNavItem(
                    data: items[index],
                    isActive: currentIndex == index,
                    isDark: isDark,
                    onTap: () => onTap(index),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Single nav item with scale, bounce, and glow animations
class _AnimatedNavItem extends StatefulWidget {
  final _NavItemData data;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.data,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_AnimatedNavItem> createState() => _AnimatedNavItemState();
}

class _AnimatedNavItemState extends State<_AnimatedNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: -8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_AnimatedNavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Colors based on theme
    final activeColor = widget.isDark ? AppColors.primary : Colors.white;
    final inactiveColor = widget.isDark
        ? AppColors.textTertiaryDark
        : Colors.white.withValues(alpha: 0.6);

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _bounceAnimation.value),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.isActive
                      ? (widget.isDark
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.2))
                      : Colors.transparent,
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color:
                                (widget.isDark
                                        ? AppColors.primary
                                        : Colors.white)
                                    .withValues(alpha: 0.3),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with animated size
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        widget.isActive
                            ? widget.data.activeIcon
                            : widget.data.icon,
                        key: ValueKey(widget.isActive),
                        color: widget.isActive ? activeColor : inactiveColor,
                        size: widget.isActive ? 26 : 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Label with fade animation
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        color: widget.isActive ? activeColor : inactiveColor,
                        fontSize: widget.isActive ? 12 : 11,
                        fontWeight: widget.isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                        letterSpacing: widget.isActive ? 0.5 : 0,
                      ),
                      child: Text(widget.data.label),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
