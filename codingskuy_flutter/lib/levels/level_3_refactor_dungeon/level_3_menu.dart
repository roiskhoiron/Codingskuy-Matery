import 'package:flutter/material.dart';
import '../../core/navigation/routes.dart';

class Level3Menu extends StatelessWidget {
  const Level3Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 3: Refactor Dungeon'),
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
                    Icon(Icons.construction, size: 48, color: Colors.orange),
                    SizedBox(height: 16),
                    Text(
                      'The Spaghetti Monster',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This Level is a Task Manager app implemented in a single massive file.\n\n'
                      'The "Challenge" code is hard to read, maintain, and debug. '
                      'The "Solution" code breaks it down into proper architecture.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.level3Challenge),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade900,
              ),
              child: const Text('Open Challenge Code'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.level3Solution),
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
