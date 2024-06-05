import 'package:flutter/material.dart';
import 'package:settings_page/utils/app_constants.dart';
import 'package:settings_page/views/screens/admin_page/admin_page.dart';
import 'package:settings_page/views/screens/home_screen.dart';
import 'package:settings_page/views/screens/onboarding.dart';
import 'package:settings_page/views/screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const CustomDrawer({
    super.key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppConstants.appColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Hotels",
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
                Text(
                  "Menu",
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return HomeScreen(
                      onThemeChanged: onThemeChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            title: Text(
              "Main page",
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return SettingsScreen(
                      onThemeChanged: onThemeChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            title: Text(
              "Settings",
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return AdminPage(
                      onThemeChanged: onThemeChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            title: Text(
              "Admin page",
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Onboarding(
                      onThemeChanged: onThemeChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            child: Text(
              'Log out',
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
