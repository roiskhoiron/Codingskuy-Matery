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
import kotlinx.coroutines.launch

@Composable
fun AsyncChallengeScreen(onBack: () -> Unit) {
    var products by remember { mutableStateOf(listOf<String>()) }
    var isLoading by remember { mutableStateOf(false) }
    
    // Intentional Flaw: Launching a coroutine directly in the body!
    // Every time this recomposes, it launches a new fetch.
    // If fetching triggers a state update, that triggers recomposition...
    // INFINITE LOOP!
    val scope = rememberCoroutineScope()
    
    // BAD CODE:
    scope.launch {
        println("Challenge: Fetching products...")
        isLoading = true
        delay(1000) 
        products = listOf("Laptop", "Mouse", "Keyboard")
        isLoading = false
        // State update triggers recomposition, which runs 'scope.launch' again!
    }
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Async Chaos") },
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
            Text("WARNING: Check Logcat. Infinite loop is likely running!")
            
            if (isLoading) {
                CircularProgressIndicator()
            } else {
                LazyColumn {
                    items(products) { product ->
                        Text(product, style = MaterialTheme.typography.bodyLarge, modifier = Modifier.padding(8.dp))
                    }
                }
            }
            
            Button(onClick = { isLoading = !isLoading }) {
                Text("Force Recomposition")
            }
        }
    }
}
