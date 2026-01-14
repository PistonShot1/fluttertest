import 'package:flutter/material.dart';

extension ColorSchemeExtension on BuildContext {
  // ============================================
  // BASE THEME COLOR ACCESSORS
  // ============================================
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get onBackgroundColor => Theme.of(this).colorScheme.onSurface;
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get onSurfaceColor => Theme.of(this).colorScheme.onSurface;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get onSecondaryColor => Theme.of(this).colorScheme.onSecondary;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get onErrorColor => Theme.of(this).colorScheme.onError;
  Color get surfaceContainerColor =>
      Theme.of(this).colorScheme.surfaceContainer;
  Color get primaryContainerColor =>
      Theme.of(this).colorScheme.primaryContainer;
  Color get secondaryContainerColor =>
      Theme.of(this).colorScheme.secondaryContainer;
  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;
  Color get onTertiaryColor => Theme.of(this).colorScheme.onTertiary;
  Color get tertiaryContainerColor =>
      Theme.of(this).colorScheme.tertiaryContainer;
  Color get outlineColor => Theme.of(this).colorScheme.outline;
  Color get outlineVariantColor => Theme.of(this).colorScheme.outlineVariant;

  // ============================================
  // ZETRIX RED PALETTE (Primary Brand Color)
  // Based on the red "Z" in the logo
  // ============================================

  /// Zetrix Brand Red - Primary accent color
  Color get zetrixRed => const Color(0xFFCC2229);

  /// Lightest red - for subtle backgrounds
  Color get zetrixRed50 => const Color(0xFFFEF2F2);

  /// Very light red - for hover states on light backgrounds
  Color get zetrixRed100 => const Color(0xFFFEE2E2);

  /// Light red - for light containers
  Color get zetrixRed200 => const Color(0xFFFECACA);

  /// Soft red - for secondary elements
  Color get zetrixRed300 => const Color(0xFFFCA5A5);

  /// Medium light red - for active states
  Color get zetrixRed400 => const Color(0xFFF87171);

  /// Medium red - for standard buttons
  Color get zetrixRed500 => const Color(0xFFEF4444);

  /// Zetrix brand red - PRIMARY
  Color get zetrixRed600 => const Color(0xFFCC2229);

  /// Deep red - for pressed states
  Color get zetrixRed700 => const Color(0xFFB91C1C);

  /// Dark red - for emphasis
  Color get zetrixRed800 => const Color(0xFF991B1B);

  /// Darkest red - for dark mode accents
  Color get zetrixRed900 => const Color(0xFF7F1D1D);

  /// Ultra dark red - for dark containers
  Color get zetrixRed950 => const Color(0xFF450A0A);

  // ============================================
  // ZETRIX SILVER/STEEL PALETTE (Secondary)
  // Based on the brushed metal "ETRIX" text
  // ============================================

  /// Zetrix Silver - Secondary color
  Color get zetrixSilver => const Color(0xFFA8A9AD);

  /// Brightest silver - almost white
  Color get zetrixSilver50 => const Color(0xFFFAFAFB);

  /// Very light silver
  Color get zetrixSilver100 => const Color(0xFFF4F4F5);

  /// Light silver - for backgrounds
  Color get zetrixSilver200 => const Color(0xFFE4E4E7);

  /// Soft silver - metallic highlight
  Color get zetrixSilver300 => const Color(0xFFD4D4D8);

  /// Medium silver - brushed metal look
  Color get zetrixSilver400 => const Color(0xFFA1A1AA);

  /// Standard silver
  Color get zetrixSilver500 => const Color(0xFF71717A);

  /// Deep silver - for text
  Color get zetrixSilver600 => const Color(0xFF52525B);

  /// Dark silver - gunmetal
  Color get zetrixSilver700 => const Color(0xFF3F3F46);

  /// Darker silver - charcoal
  Color get zetrixSilver800 => const Color(0xFF27272A);

  /// Darkest silver - near black
  Color get zetrixSilver900 => const Color(0xFF18181B);

  /// Ultra dark - for dark mode backgrounds
  Color get zetrixSilver950 => const Color(0xFF09090B);

  // ============================================
  // BRUSHED STEEL PALETTE
  // Specific metallic silver tones from logo
  // ============================================

  /// Polished steel highlight
  Color get steelHighlight => const Color(0xFFE8E8EC);

  /// Brushed steel light
  Color get steelLight => const Color(0xFFCDCDD3);

  /// Brushed steel medium
  Color get steelMedium => const Color(0xFFB0B0B8);

  /// Brushed steel standard
  Color get steel => const Color(0xFF8E8E96);

  /// Brushed steel dark
  Color get steelDark => const Color(0xFF6E6E76);

  /// Brushed steel shadow
  Color get steelShadow => const Color(0xFF4E4E56);

  /// Brushed steel deep
  Color get steelDeep => const Color(0xFF3A3A42);

  // ============================================
  // WHITE PALETTE
  // Various white tones for light mode
  // ============================================

  /// Pure white
  Color get white => const Color(0xFFFFFFFF);

  /// Snow white - very slight warmth
  Color get snowWhite => const Color(0xFFFFFAFA);

  /// Ghost white - slight blue tint
  Color get ghostWhite => const Color(0xFFF8F8FF);

  /// White smoke - light grey-white
  Color get whiteSmoke => const Color(0xFFF5F5F5);

  /// Ivory - warm white
  Color get ivory => const Color(0xFFFFFFF0);

  /// Floral white - cream tint
  Color get floralWhite => const Color(0xFFFFFAF0);

  /// Linen - warm neutral white
  Color get linen => const Color(0xFFFAF0E6);

  /// Alabaster - clean off-white
  Color get alabaster => const Color(0xFFFBFBFB);

  /// Seashell - pink-tinted white
  Color get seashell => const Color(0xFFFFF5EE);

  /// Mint cream - cool white
  Color get mintCream => const Color(0xFFF5FFFA);

  // ============================================
  // DARK BACKGROUND PALETTE
  // For dark mode matching Zetrix aesthetic
  // ============================================

  /// Darkest background - true dark
  Color get darkBg950 => const Color(0xFF0A0A0C);

  /// Very dark background
  Color get darkBg900 => const Color(0xFF111114);

  /// Dark background - primary
  Color get darkBg800 => const Color(0xFF18181C);

  /// Dark surface - elevated
  Color get darkBg700 => const Color(0xFF212126);

  /// Dark surface container
  Color get darkBg600 => const Color(0xFF2A2A30);

  /// Dark surface container high
  Color get darkBg500 => const Color(0xFF35353C);

  /// Dark muted - for disabled
  Color get darkBg400 => const Color(0xFF44444C);

  /// Dark border color
  Color get darkBg300 => const Color(0xFF55555E);

  // ============================================
  // SEMANTIC COLORS
  // ============================================

  /// Success green
  Color get successColor => const Color(0xFF10B981);
  Color get successLight => const Color(0xFFD1FAE5);
  Color get successDark => const Color(0xFF059669);

  /// Warning amber
  Color get warningColor => const Color(0xFFF59E0B);
  Color get warningLight => const Color(0xFFFEF3C7);
  Color get warningDark => const Color(0xFFD97706);

  /// Info blue
  Color get infoColor => const Color(0xFF3B82F6);
  Color get infoLight => const Color(0xFFDBEAFE);
  Color get infoDark => const Color(0xFF2563EB);

  /// Danger/Error - uses Zetrix red
  Color get dangerColor => const Color(0xFFCC2229);
  Color get dangerLight => const Color(0xFFFEE2E2);
  Color get dangerDark => const Color(0xFFB91C1C);

  // ============================================
  // LEGACY COLOR SUPPORT
  // ============================================

  Color get blueColor => const Color(0xFF0066FF);
  Color get greenColor => const Color(0xFF319F43);
  Color get orangeColor => const Color(0xFFFF7A00);
  Color get maroonColor => const Color(0xFF9F313E);
  Color get greyColor => const Color(0xFFCACACA);
  Color get redColor => const Color(0xFFCC2229);
}

class AppColor {
  // ============================================
  // LIGHT COLOR SCHEME
  // Clean white background with red/silver accents
  // ============================================

  static ColorScheme getLightColorScheme() {
    return const ColorScheme(
      brightness: Brightness.light,

      // Primary - Zetrix Red
      primary: Color(0xFFCC2229),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFEE2E2),
      onPrimaryContainer: Color(0xFF7F1D1D),

      // Secondary - Zetrix Silver/Steel
      secondary: Color(0xFF6E6E76),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE4E4E7),
      onSecondaryContainer: Color(0xFF27272A),

      // Tertiary - Brushed Steel Accent
      tertiary: Color(0xFF8E8E96),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF4F4F5),
      onTertiaryContainer: Color(0xFF3F3F46),

      // Error - Uses Zetrix Red variant
      error: Color(0xFFB91C1C),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFECACA),
      onErrorContainer: Color(0xFF7F1D1D),

      // Surface - Clean White
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF18181B),
      surfaceContainerHighest: Color(0xFFE4E4E7),
      surfaceContainerHigh: Color(0xFFEFEFF1),
      surfaceContainer: Color(0xFFF4F4F5),
      surfaceContainerLow: Color(0xFFF9F9FA),
      surfaceContainerLowest: Color(0xFFFFFFFF),

      // Outline
      outline: Color(0xFFD4D4D8),
      outlineVariant: Color(0xFFE4E4E7),

      // Inverse
      inverseSurface: Color(0xFF27272A),
      onInverseSurface: Color(0xFFF4F4F5),
      inversePrimary: Color(0xFFFCA5A5),

      // Shadow & Scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Surface Tint
      surfaceTint: Color(0xFFCC2229),
    );
  }

  // ============================================
  // DARK COLOR SCHEME
  // Deep dark background matching Zetrix aesthetic
  // ============================================

  static ColorScheme getDarkColorScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,

      // Primary - Zetrix Red (Slightly lighter for dark mode)
      primary: Color(0xFFEF4444),
      onPrimary: Color(0xFF450A0A),
      primaryContainer: Color(0xFF991B1B),
      onPrimaryContainer: Color(0xFFFECACA),

      // Secondary - Silver/Steel (Lighter for visibility)
      secondary: Color(0xFFA1A1AA),
      onSecondary: Color(0xFF18181B),
      secondaryContainer: Color(0xFF3F3F46),
      onSecondaryContainer: Color(0xFFE4E4E7),

      // Tertiary - Brushed Steel
      tertiary: Color(0xFFB0B0B8),
      onTertiary: Color(0xFF27272A),
      tertiaryContainer: Color(0xFF52525B),
      onTertiaryContainer: Color(0xFFF4F4F5),

      // Error
      error: Color(0xFFFCA5A5),
      onError: Color(0xFF450A0A),
      errorContainer: Color(0xFF7F1D1D),
      onErrorContainer: Color(0xFFFEE2E2),

      // Surface - Deep Dark
      surface: Color(0xFF111114),
      onSurface: Color(0xFFFAFAFB),
      surfaceContainerHighest: Color(0xFF35353C),
      surfaceContainerHigh: Color(0xFF2A2A30),
      surfaceContainer: Color(0xFF212126),
      surfaceContainerLow: Color(0xFF18181C),
      surfaceContainerLowest: Color(0xFF0A0A0C),

      // Outline
      outline: Color(0xFF52525B),
      outlineVariant: Color(0xFF3F3F46),

      // Inverse
      inverseSurface: Color(0xFFF4F4F5),
      onInverseSurface: Color(0xFF27272A),
      inversePrimary: Color(0xFFCC2229),

      // Shadow & Scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Surface Tint
      surfaceTint: Color(0xFFEF4444),
    );
  }

  // ============================================
  // ZETRIX BRAND GRADIENTS
  // ============================================

  /// Primary red gradient (for buttons, CTAs)
  List<Color> get zetrixRedGradient => const [
    Color(0xFFEF4444),
    Color(0xFFCC2229),
  ];

  /// Deep red gradient (for emphasis)
  List<Color> get zetrixDeepRedGradient => const [
    Color(0xFFCC2229),
    Color(0xFF991B1B),
  ];

  /// Dark red gradient (for dark mode elements)
  List<Color> get zetrixDarkRedGradient => const [
    Color(0xFF991B1B),
    Color(0xFF7F1D1D),
  ];

  /// Light red gradient (for backgrounds)
  List<Color> get zetrixLightRedGradient => const [
    Color(0xFFFEE2E2),
    Color(0xFFFECACA),
  ];

  // ============================================
  // BRUSHED STEEL GRADIENTS
  // Mimics the metallic look of "ETRIX"
  // ============================================

  /// Brushed steel gradient - horizontal shine
  List<Color> get brushedSteelGradient => const [
    Color(0xFFE8E8EC),
    Color(0xFFB0B0B8),
    Color(0xFF8E8E96),
    Color(0xFFB0B0B8),
    Color(0xFFE8E8EC),
  ];

  /// Light steel gradient
  List<Color> get lightSteelGradient => const [
    Color(0xFFFAFAFB),
    Color(0xFFE4E4E7),
  ];

  /// Medium steel gradient
  List<Color> get mediumSteelGradient => const [
    Color(0xFFD4D4D8),
    Color(0xFFA1A1AA),
  ];

  /// Dark steel gradient
  List<Color> get darkSteelGradient => const [
    Color(0xFF71717A),
    Color(0xFF52525B),
  ];

  /// Gunmetal gradient
  List<Color> get gunmetalGradient => const [
    Color(0xFF52525B),
    Color(0xFF3F3F46),
  ];

  // ============================================
  // DARK MODE SURFACE GRADIENTS
  // ============================================

  /// Dark surface gradient
  List<Color> get darkSurfaceGradient => const [
    Color(0xFF18181C),
    Color(0xFF111114),
  ];

  /// Dark elevated gradient
  List<Color> get darkElevatedGradient => const [
    Color(0xFF2A2A30),
    Color(0xFF212126),
  ];

  /// Dark card gradient
  List<Color> get darkCardGradient => const [
    Color(0xFF212126),
    Color(0xFF18181C),
  ];

  // ============================================
  // LIGHT MODE SURFACE GRADIENTS
  // ============================================

  /// White surface gradient
  List<Color> get whiteSurfaceGradient => const [
    Color(0xFFFFFFFF),
    Color(0xFFFAFAFB),
  ];

  /// Light card gradient
  List<Color> get lightCardGradient => const [
    Color(0xFFF9F9FA),
    Color(0xFFF4F4F5),
  ];

  /// Silver white gradient
  List<Color> get silverWhiteGradient => const [
    Color(0xFFFFFFFF),
    Color(0xFFE4E4E7),
  ];

  // ============================================
  // LEGACY GRADIENT SUPPORT
  // ============================================

  List<Color> get purpleColorGradient => const [
    Color(0xFFDF98FA),
    Color(0xFF9055FF),
  ];

  List<Color> get orangeColorGradient => const [
    Color(0xFFFFA881),
    Color(0xFFF35F1A),
  ];

  List<Color> get redColorGradient => const [
    Color(0xFFF87171),
    Color(0xFFCC2229),
  ];

  List<Color> get darkPurpleColorGradient => const [
    Color(0xFF403E53),
    Color(0xFF302847),
  ];

  List<Color> get darkOrangeColorGradient => const [
    Color(0xFF482B17),
    Color(0xFF2B1700),
  ];

  List<Color> get darkRedColorGradient => const [
    Color(0xFF450A0A),
    Color(0xFF1C0505),
  ];

  // ============================================
  // STATIC COLOR CONSTANTS
  // For use without instantiation
  // ============================================

  // Zetrix Red Shades
  static const Color zetrixRed50 = Color(0xFFFEF2F2);
  static const Color zetrixRed100 = Color(0xFFFEE2E2);
  static const Color zetrixRed200 = Color(0xFFFECACA);
  static const Color zetrixRed300 = Color(0xFFFCA5A5);
  static const Color zetrixRed400 = Color(0xFFF87171);
  static const Color zetrixRed500 = Color(0xFFEF4444);
  static const Color zetrixRed600 = Color(0xFFCC2229); // Brand primary
  static const Color zetrixRed700 = Color(0xFFB91C1C);
  static const Color zetrixRed800 = Color(0xFF991B1B);
  static const Color zetrixRed900 = Color(0xFF7F1D1D);
  static const Color zetrixRed950 = Color(0xFF450A0A);

  // Zetrix Silver/Steel Shades
  static const Color zetrixSilver50 = Color(0xFFFAFAFB);
  static const Color zetrixSilver100 = Color(0xFFF4F4F5);
  static const Color zetrixSilver200 = Color(0xFFE4E4E7);
  static const Color zetrixSilver300 = Color(0xFFD4D4D8);
  static const Color zetrixSilver400 = Color(0xFFA1A1AA);
  static const Color zetrixSilver500 = Color(0xFF71717A);
  static const Color zetrixSilver600 = Color(0xFF52525B);
  static const Color zetrixSilver700 = Color(0xFF3F3F46);
  static const Color zetrixSilver800 = Color(0xFF27272A);
  static const Color zetrixSilver900 = Color(0xFF18181B);
  static const Color zetrixSilver950 = Color(0xFF09090B);

  // Brushed Steel
  static const Color steelHighlight = Color(0xFFE8E8EC);
  static const Color steelLight = Color(0xFFCDCDD3);
  static const Color steelMedium = Color(0xFFB0B0B8);
  static const Color steel = Color(0xFF8E8E96);
  static const Color steelDark = Color(0xFF6E6E76);
  static const Color steelShadow = Color(0xFF4E4E56);
  static const Color steelDeep = Color(0xFF3A3A42);

  // Dark Backgrounds
  static const Color darkBg950 = Color(0xFF0A0A0C);
  static const Color darkBg900 = Color(0xFF111114);
  static const Color darkBg800 = Color(0xFF18181C);
  static const Color darkBg700 = Color(0xFF212126);
  static const Color darkBg600 = Color(0xFF2A2A30);
  static const Color darkBg500 = Color(0xFF35353C);
  static const Color darkBg400 = Color(0xFF44444C);
  static const Color darkBg300 = Color(0xFF55555E);

  // Pure Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
