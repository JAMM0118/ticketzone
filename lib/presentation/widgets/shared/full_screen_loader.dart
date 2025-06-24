import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});
  Stream<String> getloadingMessages() {
    final messages = <String>[
      'Please wait',
      'Fetching data',
      'Almost there',
      'Just a moment',
      'Hang tight',
      'Preparing your content',
      'Loading your experience',
      'Getting things ready',
      'We are on it',
      'Check your internet connection',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Text(
            'Loading',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          CircularProgressIndicator(strokeWidth: 4),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getloadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading events..");
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
