import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_max),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.event),
          label: 'Tickets',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Profile',
        ),
        
      ]
    );
  }
}