import 'package:flutter/material.dart';

class ProcessingLoader extends StatelessWidget {
  final String message;
  const ProcessingLoader({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.7),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(strokeWidth: 2),
            const SizedBox(height: 10),
            Text(message,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}
