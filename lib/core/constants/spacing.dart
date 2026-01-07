// =============================================================================
// SPACING CONSTANTS - Consistent Spacing Throughout the App
// =============================================================================
// This file defines all spacing values used for margins, padding, and gaps.
// Using consistent spacing creates visual harmony and easier maintenance.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: All UI components and screens
// - Dependencies: None (base file)
// =============================================================================

/// Spacing constants for consistent layout throughout the app.
///
/// Based on an 8px grid system for visual consistency.
/// Use these values instead of hardcoded numbers.
class Spacing {
  // Private constructor to prevent instantiation
  Spacing._();

  // ===========================================================================
  // BASE SPACING UNIT
  // ===========================================================================

  /// Base spacing unit (8px)
  static const double unit = 8.0;

  // ===========================================================================
  // STANDARD SPACING VALUES
  // ===========================================================================

  /// Extra small spacing (4px) - Tight spacing for inline elements
  static const double xs = 4.0;

  /// Small spacing (8px) - Compact spacing
  static const double sm = 8.0;

  /// Medium spacing (16px) - Default spacing for most elements
  static const double md = 16.0;

  /// Large spacing (24px) - Section spacing
  static const double lg = 24.0;

  /// Extra large spacing (32px) - Major section breaks
  static const double xl = 32.0;

  /// Double extra large spacing (48px) - Screen margins
  static const double xxl = 48.0;

  /// Triple extra large spacing (64px) - Hero sections
  static const double xxxl = 64.0;

  // ===========================================================================
  // SCREEN PADDING
  // ===========================================================================

  /// Horizontal padding for screen content
  static const double screenHorizontal = 24.0;

  /// Vertical padding for screen content
  static const double screenVertical = 16.0;

  /// Safe area additional padding
  static const double safeArea = 8.0;

  // ===========================================================================
  // COMPONENT-SPECIFIC SPACING
  // ===========================================================================

  /// Button internal padding (horizontal)
  static const double buttonPaddingH = 24.0;

  /// Button internal padding (vertical)
  static const double buttonPaddingV = 16.0;

  /// Card internal padding
  static const double cardPadding = 16.0;

  /// Input field internal padding (horizontal)
  static const double inputPaddingH = 16.0;

  /// Input field internal padding (vertical)
  static const double inputPaddingV = 16.0;

  /// List item vertical spacing
  static const double listItemSpacing = 12.0;

  /// Icon and text gap
  static const double iconTextGap = 12.0;

  /// Section title bottom margin
  static const double sectionTitleMargin = 16.0;

  // ===========================================================================
  // BORDER RADIUS
  // ===========================================================================

  /// Small border radius (8px) - Buttons, chips
  static const double radiusSm = 8.0;

  /// Medium border radius (12px) - Cards, inputs
  static const double radiusMd = 12.0;

  /// Large border radius (16px) - Neumorphic containers
  static const double radiusLg = 16.0;

  /// Extra large border radius (24px) - Modal sheets
  static const double radiusXl = 24.0;

  /// Circular radius (999px) - Avatars, pills
  static const double radiusCircle = 999.0;

  /// Full radius (same as circle) for pill shapes
  static const double radiusFull = 999.0;

  // ===========================================================================
  // NEUMORPHIC-SPECIFIC VALUES
  // ===========================================================================

  /// Neumorphic shadow blur radius
  static const double neuBlur = 12.0;

  /// Neumorphic shadow blur radius (small)
  static const double neuBlurSm = 6.0;

  /// Neumorphic shadow offset distance
  static const double neuOffset = 6.0;

  /// Neumorphic shadow offset distance (small)
  static const double neuOffsetSm = 3.0;

  /// Neumorphic shadow offset distance (large)
  static const double neuOffsetLg = 10.0;

  // ===========================================================================
  // SIZES
  // ===========================================================================

  /// Icon size - Small (16px)
  static const double iconSm = 16.0;

  /// Icon size - Medium (24px) - Default
  static const double iconMd = 24.0;

  /// Icon size - Large (32px)
  static const double iconLg = 32.0;

  /// Icon size - Extra large (48px)
  static const double iconXl = 48.0;

  /// Avatar size - Small (32px)
  static const double avatarSm = 32.0;

  /// Avatar size - Medium (48px)
  static const double avatarMd = 48.0;

  /// Avatar size - Large (64px)
  static const double avatarLg = 64.0;

  /// Button height - Small
  static const double buttonHeightSm = 40.0;

  /// Button height - Medium (default)
  static const double buttonHeightMd = 52.0;

  /// Button height - Large
  static const double buttonHeightLg = 60.0;

  /// Input field height
  static const double inputHeight = 56.0;

  /// Bottom navigation height
  static const double bottomNavHeight = 64.0;

  /// App bar height
  static const double appBarHeight = 56.0;

  /// Mini player height
  static const double miniPlayerHeight = 64.0;
}
