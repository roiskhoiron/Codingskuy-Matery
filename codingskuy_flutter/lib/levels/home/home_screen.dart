import 'package:flutter/material.dart';
import '../../core/widgets/level_card.dart';
import '../../core/navigation/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning Challenges'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Welcome! Each level teaches Flutter concepts through intentionally flawed code that you must understand and fix.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          LevelCard(
            title: 'Level 1: Rebuild Mystery',
            description: 'Learn how Flutter rebuilds work',
            icon: Icons.refresh,
            color: Colors.blue,
            onTap: () => Navigator.pushNamed(context, AppRoutes.level1Menu),
          ),
          const SizedBox(height: 12),
          LevelCard(
            title: 'Level 2: State Survival',
            description: 'Master state lifecycle management',
            icon: Icons.storage,
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, AppRoutes.level2Menu),
          ),
          const SizedBox(height: 12),
          LevelCard(
            title: 'Level 3: Refactor Dungeon',
            description: 'Clean up messy code architecture',
            icon: Icons.construction,
            color: Colors.orange,
            onTap: () => Navigator.pushNamed(context, AppRoutes.level3Menu),
          ),
          const SizedBox(height: 12),
          LevelCard(
            title: 'Level 4: Async Chaos',
            description: 'Handle async operations properly',
            icon: Icons.sync,
            color: Colors.purple,
            onTap: () => Navigator.pushNamed(context, AppRoutes.level4Menu),
          ),
          const SizedBox(height: 12),
          LevelCard(
            title: 'Level 5: Bug Hunter',
            description: 'Debug race conditions and timing issues',
            icon: Icons.bug_report,
            color: Colors.red,
            onTap: () => Navigator.pushNamed(context, AppRoutes.level5Menu),
          ),
        ],
      ),
    );
  }
}
