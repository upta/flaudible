import 'package:app/audible_icons_icons.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  final _screens = [
    HomeScreen(),
    const Scaffold(body: Center(child: Text("Library"))),
    const Scaffold(body: Center(child: Text("Discover"))),
    const Scaffold(body: Center(child: Text("Profile"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _screens
            .asMap()
            .map(
              (i, a) => MapEntry(
                i,
                Offstage(
                  child: a,
                  offstage: _selectedIndex != i,
                ),
              ),
            )
            .values
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        iconSize: 28.0,
        items: [
          _icon(
            icon: AudibleIcons.home_outline,
            activeIcon: AudibleIcons.home,
            label: 'Home',
          ),
          _icon(
              icon: AudibleIcons.library_books,
              activeIcon: AudibleIcons.library_books,
              label: 'Library',
              inactiveColor: Colors.grey.shade600),
          _icon(
            icon: AudibleIcons.discover_outline,
            activeIcon: AudibleIcons.discover,
            label: 'Discover',
          ),
          _icon(
            icon: AudibleIcons.profile_outline,
            activeIcon: AudibleIcons.profile,
            label: 'Profile',
          ),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12.0,
      ),
    );
  }

  BottomNavigationBarItem _icon({
    required IconData icon,
    required IconData activeIcon,
    required String? label,
    Color? inactiveColor,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Icon(
          icon,
          size: 22.0,
          color: inactiveColor,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Icon(
          activeIcon,
          size: 22.0,
        ),
      ),
      label: label,
    );
  }
}
