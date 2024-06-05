import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:settings_page/utils/app_constants.dart';
import 'package:settings_page/views/screens/main_screen/main_screen.dart';
import 'package:settings_page/views/screens/profile_screen.dart';
import 'package:settings_page/views/screens/results_screen.dart';
import 'package:settings_page/views/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = const <Widget>[
    MainScreen(),
    ResultsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isMobile = constraints.maxWidth < 600;
      return Scaffold(
        backgroundColor: const Color(0xff3450A1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Color(0xff91AEF9),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                AppConstants.language,
                style: const TextStyle(color: Color(0xff91AEF9), fontSize: 20),
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            if (!isMobile)
              NavigationRail(
                backgroundColor: Colors.amber,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Main'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.auto_graph_outlined),
                    label: Text('Results'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
                labelType: NavigationRailLabelType.selected,
                onDestinationSelected: (int value) =>
                    setState(() => _currentIndex = value),
                selectedIndex: _currentIndex,
              ),
            Expanded(child: _pages[_currentIndex])
          ],
        ),
        drawer: CustomDrawer(
          onThemeChanged: widget.onThemeChanged,
          onLanguageChanged: widget.onLanguageChanged,
          onColorChanged: widget.onColorChanged,
          onTextChanged: widget.onTextChanged,
        ),
        bottomNavigationBar: isMobile
            ? CurvedNavigationBar(
                index: _currentIndex,
                height: 60.0,
                items: const <Widget>[
                  Icon(Icons.home, size: 30, color: Colors.white),
                  Icon(Icons.stacked_bar_chart_rounded,
                      size: 30, color: Colors.white),
                  Icon(Icons.person, size: 30, color: Colors.white),
                ],
                color: const Color(0xff041955),
                buttonBackgroundColor: const Color(0xff041955).withOpacity(.5),
                backgroundColor: Colors.transparent,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 600),
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              )
            : null,
      );
    });
  }
}
