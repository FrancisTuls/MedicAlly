import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:material_symbols_icons/outlined.dart';
import 'package:material_symbols_icons/outlined_suffix.dart';
import 'package:material_symbols_icons/rounded_suffix.dart';
import 'package:material_symbols_icons/sharp_suffix.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:medic_ally/src/features/core/screens/dashboard/dashboard.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentPageIndex = 0;
  final screens = [
    const Dashboard(),
    const Center(
      child: Text('Medicines', style: TextStyle(fontSize: 72)),
    ),
    const Center(
      child: Text('Schedule', style: TextStyle(fontSize: 72)),
    ),
    const Center(
      child: Text('Account', style: TextStyle(fontSize: 72)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.medication_outlined),
              selectedIcon: Icon(Icons.medication),
              label: "Medicines"),
          NavigationDestination(
              icon: Icon(Icons.today_outlined),
              selectedIcon: Icon(Icons.today),
              label: "Schedule"),
          NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: "Account"),
        ],
      ),
    );
  }
}
