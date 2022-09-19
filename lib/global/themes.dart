import 'package:flex_color_scheme/flex_color_scheme.dart';

final theme = FlexThemeData.light(
      scheme: FlexScheme.deepPurple,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 20,
      appBarOpacity: 0.95,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        blendOnColors: false,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    ),
    darkTheme = FlexThemeData.dark(
      scheme: FlexScheme.deepPurple,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 15,
      appBarOpacity: 0.90,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 30,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
