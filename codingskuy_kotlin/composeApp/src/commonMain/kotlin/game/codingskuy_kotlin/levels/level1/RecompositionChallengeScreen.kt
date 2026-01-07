package game.codingskuy_kotlin.levels.level1

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import kotlin.random.Random

// Intentional Flaw: Unstable params and frequent recompositions
@Composable
fun RecompositionChallengeScreen(onBack: () -> Unit) {
    // This state change causes the entire function to recompose
    var counter by remember { mutableIntStateOf(0) }
    
    // Side effect in body! Prints log every recomposition
    println("Challenge: Main Screen Recomposed")
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Recomposition Mystery") },
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
            Text("Tip: Check Logcat for 'Challenge:' tags")
            
            Card(
                colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.primaryContainer)
            ) {
                Column(
                    modifier = Modifier.padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text("Counter: $counter", style = MaterialTheme.typography.headlineMedium)
                    Spacer(modifier = Modifier.height(8.dp))
                    Button(onClick = { counter++ }) {
                        Text("Increment")
                    }
                }
            }
            
            // This composable takes NO parameters, but because it's defined inside
            // a function that's recomposing, and maybe not skipped, it might recompose?
            // Actually in Compose, functions without args are skipped well, BUT...
            // Let's pass a value that changes often or an unstable lambda to force it.
            ExpensiveSubView(modifier = Modifier.background(RandomColor()))
        }
    }
}

// Helper to generate a random color, forcing a param change if used inline
@Composable
fun RandomColor(): Color {
    return Color(Random.nextFloat(), Random.nextFloat(), Random.nextFloat())
}

@Composable
fun ExpensiveSubView(modifier: Modifier = Modifier) {
    println("Challenge: ExpensiveSubView Recomposed")
    Box(
        modifier = modifier
            .fillMaxWidth()
            .height(100.dp)
            .padding(8.dp),
        contentAlignment = Alignment.Center
    ) {
        Text("I am a static footer but I keep redrawing!", color = Color.White)
    }
}
