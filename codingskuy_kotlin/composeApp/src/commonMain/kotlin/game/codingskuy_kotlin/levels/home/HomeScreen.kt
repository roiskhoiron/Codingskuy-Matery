package game.codingskuy_kotlin.levels.home

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Build
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material.icons.filled.Save
import androidx.compose.material.icons.filled.Visibility
import androidx.compose.material.icons.filled.Warning
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import game.codingskuy_kotlin.core.components.LevelCard
import game.codingskuy_kotlin.core.navigation.Screen

@Composable
fun HomeScreen(onNavigate: (Screen) -> Unit) {
    Scaffold(
        topBar = { TopAppBar(title = { Text("CodingSkuy Kotlin") }) }
    ) { padding ->
        Column(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .verticalScroll(rememberScrollState())
                .padding(16.dp)
        ) {
            Text(
                "Learning Path", 
                style = MaterialTheme.typography.titleLarge,
                modifier = Modifier.padding(bottom = 16.dp)
            )
            
            LevelCard(
                title = "Level 1: Recomposition Mystery",
                description = "Understand Scope and Stability",
                icon = Icons.Default.Visibility,
                color = MaterialTheme.colorScheme.primary,
                onClick = { onNavigate(Screen.Level1Menu) }
            )
            
            LevelCard(
                title = "Level 2: State Survival",
                description = "Surviving Config Changes & Process Death",
                icon = Icons.Default.Save,
                color = MaterialTheme.colorScheme.tertiary,
                onClick = { onNavigate(Screen.Level2Menu) }
            )
            
            LevelCard(
                title = "Level 3: Refactor Dungeon",
                description = "Separation of Concerns & ViewModels",
                icon = Icons.Default.Build,
                color = MaterialTheme.colorScheme.secondary,
                onClick = { onNavigate(Screen.Level3Menu) }
            )
            
            LevelCard(
                title = "Level 4: Async Chaos",
                description = "Side Effects & Coroutines",
                icon = Icons.Default.Refresh,
                color = MaterialTheme.colorScheme.primary, // Reusing primary color intent
                onClick = { onNavigate(Screen.Level4Menu) }
            )
            
            LevelCard(
                title = "Level 5: Bug Hunter",
                description = "Lifecycle & Cleanup",
                icon = Icons.Default.Warning,
                color = MaterialTheme.colorScheme.error,
                onClick = { onNavigate(Screen.Level5Menu) }
            )
        }
    }
}
