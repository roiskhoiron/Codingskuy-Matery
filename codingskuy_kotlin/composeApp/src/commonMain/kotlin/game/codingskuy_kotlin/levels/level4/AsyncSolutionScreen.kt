package game.codingskuy_kotlin.levels.level4

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay

@Composable
fun AsyncSolutionScreen(onBack: () -> Unit) {
    var products by remember { mutableStateOf(listOf<String>()) }
    var state by remember { mutableStateOf<LoadingState>(LoadingState.Idle) }
    
    // Solution: use LaunchedEffect
    // It only runs when the keys change (in this case, Unit = runs once).
    LaunchedEffect(Unit) {
        state = LoadingState.Loading
        try {
            delay(1000) // Simulate network
            products = listOf("Laptop", "Mouse", "Keyboard")
            state = LoadingState.Success
        } catch (e: Exception) {
            state = LoadingState.Error("Failed to load")
        }
    }
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Async Solution") },
                navigationIcon = {
                    Button(onClick = onBack) { Text("Back") }
                }
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            
            when(state) {
                LoadingState.Idle -> Text("Idle")
                LoadingState.Loading -> CircularProgressIndicator()
                is LoadingState.Error -> Text("Error", color = MaterialTheme.colorScheme.error)
                LoadingState.Success -> {
                    LazyColumn {
                        items(products) { product ->
                            Text(product, style = MaterialTheme.typography.bodyLarge, modifier = Modifier.padding(8.dp))
                        }
                    }
                }
            }
        }
    }
}

sealed class LoadingState {
    data object Idle : LoadingState()
    data object Loading : LoadingState()
    data object Success : LoadingState()
    data class Error(val message: String) : LoadingState()
}
