import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff204948),
      surfaceTint: Color(0xff006a68),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf1ef),
      onPrimaryContainer: Color(0xff00201f),
      secondary: Color(0xff4a6362),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e6),
      onSecondaryContainer: Color(0xff051f1f),
      tertiary: Color(0xff4a607c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd2e4ff),
      onTertiaryContainer: Color(0xff031c35),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3f4948),
      outline: Color(0xff6f7978),
      outlineVariant: Color(0xffbec9c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d2),
      primaryFixed: Color(0xff9cf1ef),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xff80d5d2),
      onPrimaryFixedVariant: Color(0xff00504f),
      secondaryFixed: Color(0xffcce8e6),
      onSecondaryFixed: Color(0xff051f1f),
      secondaryFixedDim: Color(0xffb0ccca),
      onSecondaryFixedVariant: Color(0xff324b4a),
      tertiaryFixed: Color(0xffd2e4ff),
      onTertiaryFixed: Color(0xff031c35),
      tertiaryFixedDim: Color(0xffb2c8e8),
      onTertiaryFixedVariant: Color(0xff324863),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff204948),
      surfaceTint: Color(0xff006a68),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff23817f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e4746),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f7978),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2e445e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff607693),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3b4544),
      outline: Color(0xff576160),
      outlineVariant: Color(0xff737d7c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d5d2),
      primaryFixed: Color(0xff23817f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006766),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5f7978),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff476160),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff607693),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff485d79),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002727),
      surfaceTint: Color(0xff006a68),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b4a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0c2626),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e4746),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0b233c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2e445e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1c2625),
      outline: Color(0xff3b4544),
      outlineVariant: Color(0xff3b4544),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xffa6fbf8),
      primaryFixed: Color(0xff004b4a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003332),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e4746),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff173130),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2e445e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff172e47),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d5d2),
      surfaceTint: Color(0xff80d5d2),
      onPrimary: Color(0xff003736),
      primaryContainer: Color(0xff00504f),
      onPrimaryContainer: Color(0xff9cf1ef),
      secondary: Color(0xffb0ccca),
      onSecondary: Color(0xff1b3534),
      secondaryContainer: Color(0xff324b4a),
      onSecondaryContainer: Color(0xffcce8e6),
      tertiary: Color(0xffb2c8e8),
      onTertiary: Color(0xff1b324b),
      tertiaryContainer: Color(0xff324863),
      onTertiaryContainer: Color(0xffd2e4ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e3),
      onSurfaceVariant: Color(0xffbec9c7),
      outline: Color(0xff889392),
      outlineVariant: Color(0xff3f4948),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff006a68),
      primaryFixed: Color(0xff9cf1ef),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xff80d5d2),
      onPrimaryFixedVariant: Color(0xff00504f),
      secondaryFixed: Color(0xffcce8e6),
      onSecondaryFixed: Color(0xff051f1f),
      secondaryFixedDim: Color(0xffb0ccca),
      onSecondaryFixedVariant: Color(0xff324b4a),
      tertiaryFixed: Color(0xffd2e4ff),
      onTertiaryFixed: Color(0xff031c35),
      tertiaryFixedDim: Color(0xffb2c8e8),
      onTertiaryFixedVariant: Color(0xff324863),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff84d9d7),
      surfaceTint: Color(0xff80d5d2),
      onPrimary: Color(0xff001a1a),
      primaryContainer: Color(0xff479e9c),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb5d0cf),
      onSecondary: Color(0xff001a1a),
      secondaryContainer: Color(0xff7b9695),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb6cced),
      onTertiary: Color(0xff00172e),
      tertiaryContainer: Color(0xff7c92b0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xfff6fcfb),
      onSurfaceVariant: Color(0xffc2cdcc),
      outline: Color(0xff9ba5a4),
      outlineVariant: Color(0xff7b8584),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff005150),
      primaryFixed: Color(0xff9cf1ef),
      onPrimaryFixed: Color(0xff001414),
      primaryFixedDim: Color(0xff80d5d2),
      onPrimaryFixedVariant: Color(0xff003d3c),
      secondaryFixed: Color(0xffcce8e6),
      onSecondaryFixed: Color(0xff001414),
      secondaryFixedDim: Color(0xffb0ccca),
      onSecondaryFixedVariant: Color(0xff213a3a),
      tertiaryFixed: Color(0xffd2e4ff),
      onTertiaryFixed: Color(0xff001226),
      tertiaryFixedDim: Color(0xffb2c8e8),
      onTertiaryFixedVariant: Color(0xff213751),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeafffd),
      surfaceTint: Color(0xff80d5d2),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff84d9d7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeafffd),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb5d0cf),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffafaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb6cced),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff3fdfc),
      outline: Color(0xffc2cdcc),
      outlineVariant: Color(0xffc2cdcc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff00302f),
      primaryFixed: Color(0xffa0f6f3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff84d9d7),
      onPrimaryFixedVariant: Color(0xff001a1a),
      secondaryFixed: Color(0xffd0eceb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb5d0cf),
      onSecondaryFixedVariant: Color(0xff001a1a),
      tertiaryFixed: Color(0xffd9e8ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb6cced),
      onTertiaryFixedVariant: Color(0xff00172e),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
