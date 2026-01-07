package game.codingskuy_kotlin.levels.level2

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun StateSolutionScreen(onBack: () -> Unit) {
    var showEditor by remember { mutableStateOf(false) }
    
    // Solution 1: Hoist State (Lift it up)
    // Now the state lives in the Parent, which stays in the tree.
    // Solution 2: use 'rememberSaveable' to survive configuration changes (rotation) too.
    var text by rememberSaveable { mutableStateOf("") }
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("State Solution") },
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
            
            Text("We hoisted the state to the parent. Now toggling visibility doesn't destroy the data.")
            
            Spacer(modifier = Modifier.height(16.dp))
            
            Switch(checked = showEditor, onCheckedChange = { showEditor = it })
            
            Spacer(modifier = Modifier.height(32.dp))
            
            if (showEditor) {
                SolutionEditor(text = text, onTextChange = { text = it })
            } else {
                Text("Dashboard Mode", style = MaterialTheme.typography.displaySmall)
                Text("Draft: ${text.take(10)}...", style = MaterialTheme.typography.bodySmall)
            }
        }
    }
}

@Composable
fun SolutionEditor(text: String, onTextChange: (String) -> Unit) {
    // Stateless Composable!
    Column {
        OutlinedTextField(
            value = text,
            onValueChange = onTextChange,
            label = { Text("Type something here") },
            modifier = Modifier.fillMaxWidth().height(150.dp)
        )
        Button(onClick = { println("Saved: $text") }) {
            Text("Save")
        }
    }
}
