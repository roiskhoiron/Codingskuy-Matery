import 'package:codingskuy_flutter/core/navigation/routes.dart';
import 'package:codingskuy_flutter/core/theme/app_theme.dart';
import 'package:codingskuy_flutter/levels/home/home_screen.dart';
import 'package:codingskuy_flutter/levels/level_1_rebuild_mystery/challenge/rebuild_challenge_screen.dart';
import 'package:codingskuy_flutter/levels/level_1_rebuild_mystery/level_1_menu.dart';
import 'package:codingskuy_flutter/levels/level_1_rebuild_mystery/solution/rebuild_solution_screen.dart';
import 'package:codingskuy_flutter/levels/level_2_state_survival/challenge/state_challenge_screen.dart';
import 'package:codingskuy_flutter/levels/level_2_state_survival/level_2_menu.dart';
import 'package:codingskuy_flutter/levels/level_2_state_survival/solution/state_solution_screen.dart';
import 'package:codingskuy_flutter/levels/level_3_refactor_dungeon/challenge/refactor_challenge_screen.dart';
import 'package:codingskuy_flutter/levels/level_3_refactor_dungeon/level_3_menu.dart';
import 'package:codingskuy_flutter/levels/level_3_refactor_dungeon/solution/refactor_solution_screen.dart';
import 'package:codingskuy_flutter/levels/level_4_async_chaos/challenge/async_challenge_screen.dart';
import 'package:codingskuy_flutter/levels/level_4_async_chaos/level_4_menu.dart';
import 'package:codingskuy_flutter/levels/level_4_async_chaos/solution/async_solution_screen.dart';
import 'package:codingskuy_flutter/levels/level_5_bug_hunter/challenge/bug_challenge_screen.dart';
import 'package:codingskuy_flutter/levels/level_5_bug_hunter/level_5_menu.dart';
import 'package:codingskuy_flutter/levels/level_5_bug_hunter/solution/bug_solution_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning Challenges',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        
        // Level 1
        AppRoutes.level1Menu: (context) => const Level1Menu(),
        AppRoutes.level1Challenge: (context) => const RebuildChallengeScreen(),
        AppRoutes.level1Solution: (context) => const RebuildSolutionScreen(),
        
        // Level 2
        AppRoutes.level2Menu: (context) => const Level2Menu(),
        AppRoutes.level2Challenge: (context) => const StateChallengeScreen(),
        AppRoutes.level2Solution: (context) => const StateSolutionScreen(),

        // Level 3
        AppRoutes.level3Menu: (context) => const Level3Menu(),
        AppRoutes.level3Challenge: (context) => const RefactorChallengeScreen(),
        AppRoutes.level3Solution: (context) => const RefactorSolutionScreen(),

        // Level 4
        AppRoutes.level4Menu: (context) => const Level4Menu(),
        AppRoutes.level4Challenge: (context) => const AsyncChallengeScreen(),
        AppRoutes.level4Solution: (context) => const AsyncSolutionScreen(),

        // Level 5
        AppRoutes.level5Menu: (context) => const Level5Menu(),
        AppRoutes.level5Challenge: (context) => const BugChallengeScreen(),
        AppRoutes.level5Solution: (context) => const BugSolutionScreen(),
      },
    );
  }
}
