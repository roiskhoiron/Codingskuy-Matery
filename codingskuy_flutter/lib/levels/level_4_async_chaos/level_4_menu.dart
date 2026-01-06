import 'package:flutter/material.dart';
import '../../core/navigation/routes.dart';

class Level4Menu extends StatelessWidget {
  const Level4Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 4: Async Chaos'),
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
                    Icon(Icons.sync_problem, size: 48, color: Colors.purple),
                    SizedBox(height: 16),
                    Text(
                      'The Infinite Loop of Doom',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Async operations called from the wrong place can cause infinite loops, flickering UI, and performance disasters.\n\n'
                      'Watch what happens when you try to load data in this buggy app.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.level4Challenge),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade900,
              ),
              child: const Text('Open Challenge Code'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.level4Solution),
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
