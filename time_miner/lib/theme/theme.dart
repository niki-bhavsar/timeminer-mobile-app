import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static void setSystemUi(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: AppTypography.defaultFont,
    textTheme: AppTypography.textTheme,
    filledButtonTheme: _filledButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    visualDensity: VisualDensity.standard,
    navigationBarTheme: NavigationBarThemeData(indicatorColor: lightColorScheme.tertiaryFixedDim),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      titleTextStyle: AppTypography.textTheme.headlineLarge?.copyWith(
        color: lightColorScheme.primary,
      ),
    ),
    iconTheme: IconThemeData(color: lightColorScheme.onSurface),
    // cardTheme: CardTheme(
    //   margin: EdgeInsets.zero,
    //   elevation: 0,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: _defaultBorderRadius,
    //   ),
    //   color: lightColorScheme.onPrimary,
    // ),
    dividerColor: Colors.transparent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: AppTypography.defaultFont,
    textTheme: AppTypography.textTheme,
    filledButtonTheme: _filledButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    visualDensity: VisualDensity.standard,
    navigationBarTheme: NavigationBarThemeData(indicatorColor: darkColorScheme.secondaryContainer),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      titleTextStyle: AppTypography.textTheme.headlineLarge?.copyWith(
        color: darkColorScheme.primary,
      ),
    ),
    iconTheme: IconThemeData(color: darkColorScheme.onSurface),
    // cardTheme: CardTheme(
    //   elevation: 0,
    //   margin: EdgeInsets.zero,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: _defaultBorderRadius,
    //   ),
    //   color: darkColorScheme.onPrimary,
    // ),
    dividerColor: Colors.transparent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkColorScheme.primary,
    ),
  );

  static final FilledButtonThemeData _filledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(borderRadius: _defaultBorderRadius),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16)),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, letterSpacing: 1.5),
      ),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(borderRadius: _defaultBorderRadius),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16)),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, letterSpacing: 1.5),
      ),
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder(borderRadius: _defaultBorderRadius),
    filled: true,
    isDense: true,
    contentPadding: const EdgeInsets.all(16),
    labelStyle: AppTypography.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
    hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
  );

  static const BorderRadius _defaultBorderRadius = BorderRadius.all(Radius.circular(6.0));
}
