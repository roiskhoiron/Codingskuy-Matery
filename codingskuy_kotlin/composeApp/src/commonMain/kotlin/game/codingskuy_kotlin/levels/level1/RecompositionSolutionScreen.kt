package game.codingskuy_kotlin.levels.level1

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Composable
fun RecompositionSolutionScreen(onBack: () -> Unit) {
    var counter by remember { mutableIntStateOf(0) }
    
    println("Solution: Main Screen Recomposed")
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Recomposition Solution") },
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
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            
            CounterCard(counter = counter, onIncrement = { counter++ })
            
            // Solution: Stable Modifier, Stable Params.
            // This view is now skipped during recomposition because its inputs haven't changed.
            OptimizedFooter()
        }
    }
}

// Extracting to a separate Composable makes it easier for the compiler to skip
@Composable
fun CounterCard(counter: Int, onIncrement: () -> Unit) {
    Card(
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.tertiaryContainer)
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text("Counter: $counter", style = MaterialTheme.typography.headlineMedium)
            Spacer(modifier = Modifier.height(8.dp))
            Button(onClick = onIncrement) {
                Text("Increment")
            }
        }
    }
}

@Composable
fun OptimizedFooter() {
    println("Solution: Footer Recomposed (Should be rare/once)")
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(100.dp)
            .background(Color.Gray) // Constant color
            .padding(8.dp),
        contentAlignment = Alignment.Center
    ) {
        Text("I am a stable footer.", color = Color.White)
    }
}
