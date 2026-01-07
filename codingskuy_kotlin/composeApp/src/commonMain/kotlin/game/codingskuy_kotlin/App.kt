package game.codingskuy_kotlin

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import game.codingskuy_kotlin.core.navigation.Screen
import game.codingskuy_kotlin.levels.home.HomeScreen
import game.codingskuy_kotlin.levels.level1.*
import game.codingskuy_kotlin.levels.level2.*
import game.codingskuy_kotlin.levels.level3.*
import game.codingskuy_kotlin.levels.level4.*
import game.codingskuy_kotlin.levels.level5.*
import org.jetbrains.compose.ui.tooling.preview.Preview

@Composable
@Preview
fun App() {
    MaterialTheme {
        Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
            
            // Simple State-Based Navigation Router
            var currentScreen by remember { mutableStateOf<Screen>(Screen.Home) }
            
            when(val screen = currentScreen) {
                Screen.Home -> HomeScreen(onNavigate = { currentScreen = it })
                
                // Level 1
                Screen.Level1Menu -> Level1Menu(
                    onStartChallenge = { currentScreen = Screen.Level1Challenge },
                    onStartSolution = { currentScreen = Screen.Level1Solution },
                    onBack = { currentScreen = Screen.Home }
                )
                Screen.Level1Challenge -> RecompositionChallengeScreen(onBack = { currentScreen = Screen.Level1Menu })
                Screen.Level1Solution -> RecompositionSolutionScreen(onBack = { currentScreen = Screen.Level1Menu })
                
                // Level 2
                Screen.Level2Menu -> Level2Menu(
                    onStartChallenge = { currentScreen = Screen.Level2Challenge },
                    onStartSolution = { currentScreen = Screen.Level2Solution },
                    onBack = { currentScreen = Screen.Home }
                )
                Screen.Level2Challenge -> StateChallengeScreen(onBack = { currentScreen = Screen.Level2Menu })
                Screen.Level2Solution -> StateSolutionScreen(onBack = { currentScreen = Screen.Level2Menu })

                // Level 3
                Screen.Level3Menu -> Level3Menu(
                    onStartChallenge = { currentScreen = Screen.Level3Challenge },
                    onStartSolution = { currentScreen = Screen.Level3Solution },
                    onBack = { currentScreen = Screen.Home }
                )
                Screen.Level3Challenge -> RefactorChallengeScreen(onBack = { currentScreen = Screen.Level3Menu })
                Screen.Level3Solution -> RefactorSolutionScreen(onBack = { currentScreen = Screen.Level3Menu })
                
                // Level 4
                Screen.Level4Menu -> Level4Menu(
                    onStartChallenge = { currentScreen = Screen.Level4Challenge },
                    onStartSolution = { currentScreen = Screen.Level4Solution },
                    onBack = { currentScreen = Screen.Home }
                )
                Screen.Level4Challenge -> AsyncChallengeScreen(onBack = { currentScreen = Screen.Level4Menu })
                Screen.Level4Solution -> AsyncSolutionScreen(onBack = { currentScreen = Screen.Level4Menu })
                
                // Level 5
                Screen.Level5Menu -> Level5Menu(
                    onStartChallenge = { currentScreen = Screen.Level5Challenge },
                    onStartSolution = { currentScreen = Screen.Level5Solution },
                    onBack = { currentScreen = Screen.Home }
                )
                Screen.Level5Challenge -> BugChallengeScreen(onBack = { currentScreen = Screen.Level5Menu })
                Screen.Level5Solution -> BugSolutionScreen(onBack = { currentScreen = Screen.Level5Menu })
            }
        }
    }
}