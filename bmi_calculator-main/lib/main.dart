import 'package:bmi_calculator/components/theme_settings_screen.dart';
import 'package:bmi_calculator/layout.dart';
import 'package:bmi_calculator/theme/context.dart';
import 'package:bmi_calculator/valueSelection/values.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// class MyApp: Stateful class,which rebuilds MaterialApp when theme is updated
/// it passes _setTheme as a function to update theme with parameters
///
/// properties: none
///
/// params: none
///
///private members:
/// - _setTheme(): as name suggest, it sets theme of the app and setStatus so,
///    app can rebuild widgets and adopt to changes as expected
///   params:
///   - name: name of the theme which is String "key" in colorPalate variable
///     - default: "blue",
///   - brightness: theme brightness usually dark or light
///     - default: Brightness.dark
///   - contrast: theme contrast which can be in range from -1.0 to 1.0
///     - default: 0.0
///
/// dependencies:
///  - MyAppHome: sets home property for MaterialApp
///
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData = appTheme.themeData;

  @override
  void initState() {
    super.initState();
    _setTheme(name: "blue", brightness: Brightness.dark, contrast: 0.0);
  }

  void _setTheme(
      {required String name,
      required Brightness brightness,
      required double contrast}) {
    setState(() {
      appTheme.setTitle = name;
      appTheme.setBrightness = brightness;
      appTheme.setContrast = contrast;
      _themeData = appTheme.themeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeData,
        home: MyAppHome(
          themeUpdater: _setTheme,
        ));
  }
}

/// class MyAppHome:
/// - stateless class is created here so that , we can use Theme.of(context)
/// effectively, which is used for both rendering and rebuilding UI
///
///  - it also has action button which pop-up modal from bottom to change theme
///  settings, namely , brightness, color and contrast
///
/// properties:
///  themeUpdater: variable to hold function passed from MyApp
///
/// private members:
/// _showThemeOption:
/// it is used to pop-up ThemeSettingScreen from bottom of the screen using
/// showModalBottomSheet functionality of the flutter
///
/// dependencies:
///  - BMILayout: sets apps widget Layout used as body: for Scaffold
///  - ThemeSettingsScreen: screen used for bottom Modal to change theme params
///  - AppThemeContext: for style/ color extended on BuildContext
class MyAppHome extends StatelessWidget {
  final Function(
      {required String name,
      required Brightness brightness,
      required double contrast}) themeUpdater;

  const MyAppHome({required this.themeUpdater, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        titleTextStyle: context.appTitle,
        backgroundColor: context.appBackground,
        actions: [
          IconButton(
              onPressed: () => _showThemeOptions(context),
              icon: Icon(Icons.color_lens_sharp,
                  color: context.themeSettingsIconColor))
        ],
      ),
      backgroundColor: context.appBackground,
      body: const SafeArea(child: BMIAppLayout()),
    );
  }

  _showThemeOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.8,
            builder: (context, scrollControl) {
              return SingleChildScrollView(
                controller: scrollControl,
                child: ThemeSettingsScreen(themeUpdater: themeUpdater),
              );
            },
          );
        });
  }
}

///Todo:
/// - replace google-fonts with downloaded static fonts
/// - add more units to the input such as
///   - weight: in pounds
///   - weight: in stones
///   - height: in meters
///   - height: in ft and inch
/// - convert theme settings to ValueNotifier for easy state management
/// - account for gender and age in BMI calculation instead of using simple
/// formula
///
