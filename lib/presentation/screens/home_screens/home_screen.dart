import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  final StatefulNavigationShell childView;
  
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:childView,
      bottomNavigationBar: CustomBottomNavigation( childView: childView), 
      );
  }
}
