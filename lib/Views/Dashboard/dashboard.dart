import 'package:flutter/material.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/all_notes_screen.dart';
import 'package:tution_notes/Views/home_screen.dart';
import 'package:tution_notes/Views/profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;
  List pages = [
    HomeScreen(),
    AllNotesScreen(),
    ProfileScreen(),
  ];

  void changeTab(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary_color,
        unselectedItemColor: AppColors.grey,
        currentIndex: currentTab,
        onTap: changeTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes_rounded),
            label: 'All Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
