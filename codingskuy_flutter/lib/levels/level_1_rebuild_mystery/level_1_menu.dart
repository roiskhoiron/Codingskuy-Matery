import 'package:flutter/material.dart';
import '../../core/navigation/routes.dart';

class Level1Menu extends StatelessWidget {
  const Level1Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 1: Rebuild Mystery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.refresh, size: 48, color: Colors.blue),
                    SizedBox(height: 16),
                    Text(
                      'The Mystery',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'In this challenge, the UI looks fine, but something is wrong under the hood. '
                      'Every interaction triggers way more work than necessary.\n\n'
                      'Use the Debug Console to watch the print statements!',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.level1Challenge),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade900,
              ),
              child: const Text('Open Challenge Code'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.level1Solution),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade100,
                foregroundColor: Colors.green.shade900,
              ),
              child: const Text('See Solution'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
