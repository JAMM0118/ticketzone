import 'package:flutter/material.dart';

class EventSpecificInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  const EventSpecificInfo({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
        Flexible(child: Text(subtitle, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}