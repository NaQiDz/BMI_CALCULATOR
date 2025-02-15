import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// This extension enables us to simplify access and label our theme components
/// since BuildContext instance is passed to every single Widget , we can set
/// and access specific theme by name , which are all public member.
///
/// these public members can be accessed as
/// - context.appBackground
/// - context.appTitle
/// - context.widgetBackground
/// - and... so on

extension AppThemeContext on BuildContext {
  /// color theme for app components
  Color get appBackground => Theme.of(this).colorScheme.surface;
  Color get widgetBackground => Theme.of(this).colorScheme.surfaceTint;
  Color get genderIconColor => Theme.of(this).colorScheme.onPrimary;

  Color get themeSettingsIconColor => Colors.white;

  Color get switchActiveTrackColor => Colors.white;
  Color get switchInactiveTrackColor => Colors.grey;
  Color get switchActiveThumbColor => Theme.of(this).colorScheme.primary;
  Color get switchInactiveThumbColor => Colors.black87;

  Color get sliderActiveColor => Colors.black87;
  Color get sliderInactiveColor => Colors.grey;

  /// Text theme for app components
  TextStyle get appTitle => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get widgetTitle => Theme.of(this).textTheme.titleLarge!;
  TextStyle get widgetInfo => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get resultName => Theme.of(this).textTheme.titleLarge!;

  /// variation of existing theme
  TextStyle get resultNumbers => Theme.of(this).textTheme.titleLarge!.copyWith(
      color: Theme.of(this).colorScheme.surface, fontWeight: FontWeight.bold);

  TextStyle get selectedWheelText =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
          fontFamily: GoogleFonts.roboto.toString(),
          fontWeight: FontWeight.w700,
          color: Theme.of(this).colorScheme.onPrimary);

  TextStyle get unSelectedWheelText =>
      Theme.of(this).textTheme.bodyMedium!.copyWith(
          fontFamily: GoogleFonts.roboto.toString(),
          color: Theme.of(this).colorScheme.onPrimary);

  /// Theme settings title and labels
  TextStyle get themeWidgetTitle => Theme.of(this)
      .textTheme
      .titleLarge!
      .copyWith(fontSize: 15, color: Theme.of(this).colorScheme.onPrimary);
}
