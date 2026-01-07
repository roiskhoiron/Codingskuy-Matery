package game.codingskuy_kotlin.levels.level5

import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.launch

@Composable
fun BugChallengeScreen(onBack: () -> Unit) {
    val messages = remember { mutableStateListOf<String>() }
    val scope = rememberCoroutineScope()
    
    // Intentional Flaw: Manually collecting a flow in a collection that doesn't respect lifecycle or cancellation well.
    // Or simpler: A DisposableEffect that forgets to dispose.
    
    DisposableEffect(Unit) {
        println("Challenge: Effect Started")
        
        // Simulating a listener/subscription
        val job = scope.launch {
            while(true) {
                delay(1000)
                messages.add("Message at ${Clock.now()}")
                println("Challenge: Listener Active")
            }
        }
        
        onDispose {
            // Intentional Flaw: WE FORGOT TO CANCEL THE JOB!
            // job.cancel()
             println("Challenge: Effect Disposed, but listener might leak if scope isn't bound to this node correctly (it is bound to composition, so it might be safe-ish in Compose, but let's simulate a non-compose listener).")
             
             // Let's pretend this was a global listener registration
             // Singleton.addListener(listener)
             // And we forgot Singleton.removeListener(listener)
        }
    }
    
    Scaffold(
        topBar = { TopAppBar(title = { Text("Bug Hunter (Leaks)") }, navigationIcon = { Button(onClick = onBack) { Text("Back") } }) }
    ) { padding ->
        LazyColumn(contentPadding = padding) {
            items(messages) { msg -> Text(msg) }
        }
    }
}

object Clock {
    fun now(): Long = 123456789L // Dummy
}
