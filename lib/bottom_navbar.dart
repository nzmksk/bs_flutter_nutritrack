import 'package:bs_flutter_nutritrack/pages.dart';
import 'package:flutter/material.dart';

class NutriTrackNavBar extends StatefulWidget {
  const NutriTrackNavBar({super.key});

  @override
  State<NutriTrackNavBar> createState() => _NutriTrackNavBarState();
}

class _NutriTrackNavBarState extends State<NutriTrackNavBar> {
  int _currentIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static const List<Widget> _pages = [
    NutritionPage(),
    ExercisePage(),
    HomePage(),
    SummaryPage(),
    ProfilePage(),
  ];

  static const List<String> _appBarTitle = [
    'Nutrition Info',
    'Exercise Info',
    'Calorie Logs',
    'Summary',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle.elementAt(_currentIndex)),
      ),
      body: Container(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_outlined),
            label: 'Nutrition',
            // tooltip: 'Food nutrition info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Exercise',
            // tooltip: 'Exercise calories info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            label: 'Logs',
            // tooltip: 'Calorie logs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline_outlined),
            label: 'Summary',
            // tooltip: 'Report summary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'Profile',
            // tooltip: 'Personal info',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
