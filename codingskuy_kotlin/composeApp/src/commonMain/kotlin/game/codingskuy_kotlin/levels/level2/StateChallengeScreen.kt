package game.codingskuy_kotlin.levels.level2

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun StateChallengeScreen(onBack: () -> Unit) {
    var showEditor by remember { mutableStateOf(false) }
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("State Survival") },
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
            
            Text("Tip: Toggle the editor. The text will disappear because 'remember' follows the call site location in the composition.")
            
            Spacer(modifier = Modifier.height(16.dp))
            
            Switch(checked = showEditor, onCheckedChange = { showEditor = it })
            Text(if (showEditor) "Hide Editor" else "Show Editor")
            
            Spacer(modifier = Modifier.height(32.dp))
            
            // Intentional Flaw: Conditional Logic removes the Node from the UI tree.
            // When it enters again, 'remember' initializes fresh state.
            if (showEditor) {
                ChallengeEditor()
            } else {
                Text("Dashboard Mode", style = MaterialTheme.typography.displaySmall)
            }
        }
    }
}

@Composable
fun ChallengeEditor() {
    // This state is internal to this Composable.
    // If this Composable leaves the tree, this state is lost.
    var text by remember { mutableStateOf("") }
    
    Column {
        OutlinedTextField(
            value = text,
            onValueChange = { text = it },
            label = { Text("Type something here") },
            modifier = Modifier.fillMaxWidth().height(150.dp)
        )
        Button(onClick = { println("Saved: $text") }) {
            Text("Save")
        }
    }
}
