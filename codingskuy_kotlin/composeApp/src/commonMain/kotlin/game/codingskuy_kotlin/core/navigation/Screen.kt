package game.codingskuy_kotlin.core.navigation

sealed class Screen {
    data object Home : Screen()
    
    // Level 1
    data object Level1Menu : Screen()
    data object Level1Challenge : Screen()
    data object Level1Solution : Screen()
    
    // Level 2
    data object Level2Menu : Screen()
    data object Level2Challenge : Screen()
    data object Level2Solution : Screen()
    
    // Level 3
    data object Level3Menu : Screen()
    data object Level3Challenge : Screen()
    data object Level3Solution : Screen()
    
    // Level 4
    data object Level4Menu : Screen()
    data object Level4Challenge : Screen()
    data object Level4Solution : Screen()
    
    // Level 5
    data object Level5Menu : Screen()
    data object Level5Challenge : Screen()
    data object Level5Solution : Screen()
}
