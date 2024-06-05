import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/utils/app_constants.dart';
import 'package:settings_page/utils/routes.dart';
import 'package:settings_page/views/screens/admin_page/admin_page.dart';
import 'package:settings_page/views/screens/course_info_screen/course_info_screen.dart';
import 'package:settings_page/views/screens/home_screen.dart';
import 'package:settings_page/views/screens/main_screen/main_screen.dart';
import 'package:settings_page/views/screens/onboarding.dart';
import 'package:settings_page/views/screens/profile_screen.dart';
import 'package:settings_page/views/screens/results_screen.dart';
import 'package:settings_page/views/screens/settings_screen.dart';
import 'package:settings_page/views/screens/todo_screen/todo_screen.dart';
import 'package:settings_page/views/screens/you_tube_video/you_tube_video_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleThemeMode(bool value) async {
    AppConstants.themeMode = value ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('isDark', '$value');
    setState(() {});
  }

  

  void onLanguageChanged(String language) async {
    AppConstants.language = language;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', language);
    setState(() {});
  }

  void onColorChanged(Color color) async {
    AppConstants.appColor = color;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('app-color', color.value);
    setState(() {});
  }

  void onTextChanged(Color color, double size) async {
    AppConstants.textSize = size;
    AppConstants.textColor = color;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(
      'text-val',
      jsonEncode(
        {
          'text-size': size,
          'text-color': color.value,
        },
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    AppConstants().setConstants().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.appColor,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: AppConstants.themeMode,
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.todoScreen:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const TodoScreen(),
        );
      case RouteNames.admin:
        return CupertinoPageRoute(
          builder: (BuildContext context) => AdminPage(
            onThemeChanged: toggleThemeMode,
            onLanguageChanged: onLanguageChanged,
            onColorChanged: onColorChanged,
            onTextChanged: onTextChanged,
          ),
        );
      case RouteNames.courseInfo:
        return CupertinoPageRoute(
          builder: (BuildContext context) =>
              CourseInfoScreen(course: settings.arguments as Course),
        );
      case RouteNames.mainScreen:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const MainScreen(),
        );
      case RouteNames.profileScreen:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const ProfileScreen(),
        );
      case RouteNames.onboarding:
        return CupertinoPageRoute(
          builder: (BuildContext context) => Onboarding(
            onThemeChanged: toggleThemeMode,
            onLanguageChanged: onLanguageChanged,
            onColorChanged: onColorChanged,
            onTextChanged: onTextChanged,
          ),
        );
      case RouteNames.resultScreen:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const ResultsScreen(),
        );
      case RouteNames.settingsScreen:
        return CupertinoPageRoute(
          builder: (BuildContext context) => SettingsScreen(
            onThemeChanged: toggleThemeMode,
            onLanguageChanged: onLanguageChanged,
            onColorChanged: onColorChanged,
            onTextChanged: onTextChanged,
          ),
        );
      case RouteNames.youTubeVideo:
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
          builder: (BuildContext context) => YouTubeVideoScreen(
            course: data['course'] as Course,
            index: data['index'] as int,
          ),
        );

      default:
        return CupertinoPageRoute(
          builder: (BuildContext context) => HomeScreen(
            onThemeChanged: toggleThemeMode,
            onLanguageChanged: onLanguageChanged,
            onColorChanged: onColorChanged,
            onTextChanged: onTextChanged,
          ),
        );
    }
  }
}
