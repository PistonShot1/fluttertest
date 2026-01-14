import 'package:flutter/material.dart';
import 'package:fluttertest/core/shared/theme/color/app_color.dart';

class AppTheme {
  // ============================================
  // DARK THEME
  // Deep dark background matching Zetrix aesthetic
  // ============================================

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColor.getDarkColorScheme(),
    scaffoldBackgroundColor: AppColor.getDarkColorScheme().surface,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.getDarkColorScheme().surface,
      foregroundColor: AppColor.getDarkColorScheme().onSurface,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),

    // Page Transitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),

    // Navigation Bar Theme
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColor.getDarkColorScheme().primary.withValues(
        alpha: 0.2,
      ),
      backgroundColor: AppColor.getDarkColorScheme().surface,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: AppColor.getDarkColorScheme().primary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(
          color: AppColor.getDarkColorScheme().onSurface.withValues(alpha: 0.7),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: AppColor.getDarkColorScheme().primary);
        }
        return IconThemeData(
          color: AppColor.getDarkColorScheme().onSurface.withValues(alpha: 0.7),
        );
      }),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.getDarkColorScheme().surface,
      selectedItemColor: AppColor.getDarkColorScheme().primary,
      unselectedItemColor: AppColor.getDarkColorScheme().onSurface.withValues(
        alpha: 0.6,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColor.getDarkColorScheme().surfaceContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.getDarkColorScheme().primary,
        foregroundColor: AppColor.getDarkColorScheme().onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.getDarkColorScheme().primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.getDarkColorScheme().primary,
        side: BorderSide(
          color: AppColor.getDarkColorScheme().primary,
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.getDarkColorScheme().primary,
      foregroundColor: AppColor.getDarkColorScheme().onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.getDarkColorScheme().surfaceContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.getDarkColorScheme().outline.withValues(alpha: 0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.getDarkColorScheme().primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.getDarkColorScheme().error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColor.getDarkColorScheme().surfaceContainer,
      selectedColor: AppColor.getDarkColorScheme().primary.withValues(
        alpha: 0.2,
      ),
      labelStyle: TextStyle(color: AppColor.getDarkColorScheme().onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColor.getDarkColorScheme().outline.withValues(alpha: 0.2),
      thickness: 1,
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColor.getDarkColorScheme().surfaceContainerHigh,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.getDarkColorScheme().surfaceContainerHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColor.getDarkColorScheme().inverseSurface,
      contentTextStyle: TextStyle(
        color: AppColor.getDarkColorScheme().onInverseSurface,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.getDarkColorScheme().onSurface.withValues(alpha: 0.7),
      textColor: AppColor.getDarkColorScheme().onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getDarkColorScheme().primary;
        }
        return AppColor.getDarkColorScheme().outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getDarkColorScheme().primary.withValues(alpha: 0.3);
        }
        return AppColor.getDarkColorScheme().surfaceContainer;
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getDarkColorScheme().primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(
        AppColor.getDarkColorScheme().onPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getDarkColorScheme().primary;
        }
        return AppColor.getDarkColorScheme().outline;
      }),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.getDarkColorScheme().primary,
      linearTrackColor: AppColor.getDarkColorScheme().surfaceContainer,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarThemeData(
      labelColor: AppColor.getDarkColorScheme().primary,
      unselectedLabelColor: AppColor.getDarkColorScheme().onSurface.withValues(
        alpha: 0.6,
      ),
      indicatorColor: AppColor.getDarkColorScheme().primary,
      dividerColor: Colors.transparent,
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: AppColor.getDarkColorScheme().onSurface),

    // Primary Icon Theme
    primaryIconTheme: IconThemeData(
      color: AppColor.getDarkColorScheme().onPrimary,
    ),
  );

  // ============================================
  // LIGHT THEME
  // Clean white background with red/silver accents
  // ============================================

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColor.getLightColorScheme(),
    scaffoldBackgroundColor: AppColor.getLightColorScheme().surface,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.getLightColorScheme().surface,
      foregroundColor: AppColor.getLightColorScheme().onSurface,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),

    // Page Transitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),

    // Navigation Bar Theme
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColor.getLightColorScheme().primary.withValues(
        alpha: 0.15,
      ),
      backgroundColor: AppColor.getLightColorScheme().surface,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: AppColor.getLightColorScheme().primary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(
          color: AppColor.getLightColorScheme().onSurface.withValues(
            alpha: 0.7,
          ),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: AppColor.getLightColorScheme().primary);
        }
        return IconThemeData(
          color: AppColor.getLightColorScheme().onSurface.withValues(
            alpha: 0.7,
          ),
        );
      }),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.getLightColorScheme().surface,
      selectedItemColor: AppColor.getLightColorScheme().primary,
      unselectedItemColor: AppColor.getLightColorScheme().onSurface.withValues(
        alpha: 0.6,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColor.getLightColorScheme().surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColor.getLightColorScheme().outline.withValues(alpha: 0.3),
        ),
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.getLightColorScheme().primary,
        foregroundColor: AppColor.getLightColorScheme().onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.getLightColorScheme().primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.getLightColorScheme().primary,
        side: BorderSide(
          color: AppColor.getLightColorScheme().primary,
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.getLightColorScheme().primary,
      foregroundColor: AppColor.getLightColorScheme().onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.getLightColorScheme().surfaceContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.getLightColorScheme().outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.getLightColorScheme().primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.getLightColorScheme().error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColor.getLightColorScheme().surfaceContainer,
      selectedColor: AppColor.getLightColorScheme().primary.withValues(
        alpha: 0.15,
      ),
      labelStyle: TextStyle(color: AppColor.getLightColorScheme().onSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: AppColor.getLightColorScheme().outline.withValues(alpha: 0.5),
      thickness: 1,
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColor.getLightColorScheme().surface,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.getLightColorScheme().surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColor.getLightColorScheme().inverseSurface,
      contentTextStyle: TextStyle(
        color: AppColor.getLightColorScheme().onInverseSurface,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.getLightColorScheme().onSurface.withValues(
        alpha: 0.7,
      ),
      textColor: AppColor.getLightColorScheme().onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getLightColorScheme().primary;
        }
        return AppColor.getLightColorScheme().outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getLightColorScheme().primary.withValues(alpha: 0.3);
        }
        return AppColor.getLightColorScheme().surfaceContainer;
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getLightColorScheme().primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(
        AppColor.getLightColorScheme().onPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.getLightColorScheme().primary;
        }
        return AppColor.getLightColorScheme().outline;
      }),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.getLightColorScheme().primary,
      linearTrackColor: AppColor.getLightColorScheme().surfaceContainer,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarThemeData(
      labelColor: AppColor.getLightColorScheme().primary,
      unselectedLabelColor: AppColor.getLightColorScheme().onSurface.withValues(
        alpha: 0.6,
      ),
      indicatorColor: AppColor.getLightColorScheme().primary,
      dividerColor: Colors.transparent,
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: AppColor.getLightColorScheme().onSurface),

    // Primary Icon Theme
    primaryIconTheme: IconThemeData(
      color: AppColor.getLightColorScheme().onPrimary,
    ),
  );

  // ============================================
  // CUSTOM FONT THEME GENERATOR
  // ============================================

  static ThemeData getThemeWithFont({
    required ThemeData baseTheme,
    required String fontFamily,
  }) {
    final double height = fontFamily == 'Merriweather' ? 1.7 : 1.5;
    final double letterSpacing = fontFamily == 'Merriweather' ? 0.5 : 0.3;

    final TextTheme newTextTheme = baseTheme.textTheme.copyWith(
      displayLarge: baseTheme.textTheme.displayLarge?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      displayMedium: baseTheme.textTheme.displayMedium?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      displaySmall: baseTheme.textTheme.displaySmall?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      headlineLarge: baseTheme.textTheme.headlineLarge?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      titleLarge: baseTheme.textTheme.titleLarge?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      titleSmall: baseTheme.textTheme.titleSmall?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      bodySmall: baseTheme.textTheme.bodySmall?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      labelLarge: baseTheme.textTheme.labelLarge?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      labelMedium: baseTheme.textTheme.labelMedium?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
      labelSmall: baseTheme.textTheme.labelSmall?.copyWith(
        fontFamily: fontFamily,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );

    return baseTheme.copyWith(textTheme: newTextTheme);
  }
}
