import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../provider/player_state.dart';

/// Sleep timer bottom sheet
class SleepTimerSheet extends StatelessWidget {
  final SleepTimerState timerState;
  final ValueChanged<Duration> onSetTimer;
  final VoidCallback onEndOfChapter;
  final VoidCallback onCancel;

  const SleepTimerSheet({
    super.key,
    required this.timerState,
    required this.onSetTimer,
    required this.onEndOfChapter,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.elevatedDark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Title and status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bedtime_outlined, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Sleep Timer',
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Current timer status
            if (timerState.isActive) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  timerState.endOfChapter
                      ? 'Stops at end of chapter'
                      : 'Stops in ${timerState.formattedRemaining}',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            const SizedBox(height: 8),

            // OFF option - always show at top
            _TimerOption(
              label: 'Off',
              icon: Icons.timer_off_outlined,
              isSelected: !timerState.isActive,
              onTap: () {
                if (timerState.isActive) {
                  onCancel();
                }
                Navigator.pop(context);
              },
            ),

            const Divider(color: AppColors.elevatedDark, height: 16),

            // Timer options
            ...AppConstants.sleepTimerPresets.map((minutes) {
              final isSelected =
                  timerState.isActive &&
                  !timerState.endOfChapter &&
                  timerState.duration?.inMinutes == minutes;
              return _TimerOption(
                label: '$minutes minutes',
                icon: Icons.timer_outlined,
                isSelected: isSelected,
                onTap: () {
                  onSetTimer(Duration(minutes: minutes));
                  Navigator.pop(context);
                },
              );
            }).toList(),

            _TimerOption(
              label: 'End of chapter',
              icon: Icons.bookmark_outline,
              isSelected: timerState.endOfChapter,
              onTap: () {
                onEndOfChapter();
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required SleepTimerState timerState,
    required ValueChanged<Duration> onSetTimer,
    required VoidCallback onEndOfChapter,
    required VoidCallback onCancel,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SleepTimerSheet(
        timerState: timerState,
        onSetTimer: onSetTimer,
        onEndOfChapter: onEndOfChapter,
        onCancel: onCancel,
      ),
    );
  }
}

class _TimerOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDestructive;
  final VoidCallback onTap;

  const _TimerOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? AppColors.error
        : isSelected
        ? AppColors.primary
        : AppColors.textSecondaryDark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyLarge.copyWith(color: color),
              ),
            ),
            if (isSelected)
              Icon(Icons.check, color: AppColors.primary, size: 22),
          ],
        ),
      ),
    );
  }
}
