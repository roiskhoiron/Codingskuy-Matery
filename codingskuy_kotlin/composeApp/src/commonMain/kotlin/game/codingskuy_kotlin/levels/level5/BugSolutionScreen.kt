package game.codingskuy_kotlin.levels.level5

import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch

@Composable
fun BugSolutionScreen(onBack: () -> Unit) {
    val messages = remember { mutableStateListOf<String>() }
    
    // Solution 1: LaunchedEffect automatically cancels when it leaves composition.
    LaunchedEffect(Unit) {
        println("Solution: Job Started")
        while(isActive) { // Check for cancellation
            delay(1000)
            messages.add("Safe Message")
            println("Solution: Job Running")
        }
    }
    
    // Solution 2: If using DisposableEffect for 3rd party legacy listeners
    /*
    DisposableEffect(Unit) {
        val listener = { ... }
        Manager.subscribe(listener)
        onDispose {
            Manager.unsubscribe(listener) // CLEANUP IS CRITICAL
        }
    }
    */
    
    Scaffold(
        topBar = { TopAppBar(title = { Text("Bug Solution") }, navigationIcon = { Button(onClick = onBack) { Text("Back") } }) }
    ) { padding ->
        LazyColumn(contentPadding = padding) {
            items(messages) { msg -> Text(msg) }
        }
    }
}
