import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell childView;
  const CustomBottomNavigation({super.key, required this.childView});
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: childView.currentIndex,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      onTap: (index) => childView.goBranch(index),
      elevation: 0,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      type:  BottomNavigationBarType.shifting,
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