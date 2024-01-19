import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:talk_one/screens/home.dart';
import 'package:talk_one/screens/settings.dart';
import 'package:talk_one/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    String talkBack =
        index == 0 ? 'Home page checking checking' : 'Settings page';

    setState(() {
      _selectedPageIndex = index;
      SemanticsService.announce(talkBack, TextDirection.ltr);
    });
  }

  void _selectScreen() {
    print('working');
    setState(() {
      _selectedPageIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activeTitle = 'Talk-to-one';

    Widget activeScreen = const HomeScreen();

    if (_selectedPageIndex == 1) {
      activeScreen = const SettingsScreen();
      activeTitle = 'Settings';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activeTitle,
        ),
      ),
      drawer: MainDrawer(onClosing: _selectScreen),
      // drawer
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        selectedFontSize: 16,
        selectedIconTheme: const IconThemeData(size: 26),
        elevation: 5,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedFontSize: 12,
        unselectedIconTheme: const IconThemeData(size: 20),
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_filled,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(
              Icons.settings_sharp,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
