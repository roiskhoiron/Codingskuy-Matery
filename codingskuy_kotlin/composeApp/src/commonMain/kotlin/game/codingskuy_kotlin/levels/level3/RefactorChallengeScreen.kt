package game.codingskuy_kotlin.levels.level3

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay
import kotlin.random.Random

// Intentional Flaw: Logic, Data, and UI Complexity all in one file/function.
@Composable
fun RefactorChallengeScreen(onBack: () -> Unit) {
    // Data Class defined inside Composable (BAD)
    data class Task(val id: Int, var title: String, var isCompleted: Boolean)
    
    // Logic/State
    var tasks by remember { mutableStateOf(listOf<Task>()) }
    var newTaskTitle by remember { mutableStateOf("") }
    var filter by remember { mutableStateOf("All") }
    var isLoading by remember { mutableStateOf(false) }
    
    // Coroutine Scope for side effects
    val scope = rememberCoroutineScope()
    
    // UI
    Scaffold(
        topBar = { TopAppBar(title = { Text("Task Manager (Messy)") }, navigationIcon = { Button(onClick = onBack) { Text("Back") } }) }
    ) { padding ->
        Column(modifier = Modifier.padding(padding).padding(16.dp)) {
            
            // Filter Logic mixed in UI
            Row(modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
                FilterChip(selected = filter == "All", onClick = { filter = "All" }, label = { Text("All") })
                FilterChip(selected = filter == "Pending", onClick = { filter = "Pending" }, label = { Text("Pending") })
                FilterChip(selected = filter == "Completed", onClick = { filter = "Completed" }, label = { Text("Completed") })
            }
            
            if (isLoading) LinearProgressIndicator(modifier = Modifier.fillMaxWidth())
            
            // List Logic mixed in UI
            LazyColumn(modifier = Modifier.weight(1f)) {
                items(tasks.filter { 
                    when(filter) {
                        "Pending" -> !it.isCompleted
                        "Completed" -> it.isCompleted
                        else -> true
                    }
                }) { task ->
                    // Item Logic mixed in UI
                    Row(
                        modifier = Modifier.fillMaxWidth().padding(8.dp).clickable {
                             // Mutating list state is tricky with immutable lists in Compose best practices,
                             // but here we are doing it the "easy/bad" way if using mutableStateList, 
                             // OR rebuilding the list if using List.
                             tasks = tasks.map { if (it.id == task.id) it.copy(isCompleted = !it.isCompleted) else it }
                        },
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Checkbox(checked = task.isCompleted, onCheckedChange = null) // Handled by row click
                        Text(
                            text = task.title,
                            textDecoration = if (task.isCompleted) TextDecoration.LineThrough else null,
                            color = if (task.isCompleted) Color.Gray else Color.Unspecified
                        )
                    }
                    HorizontalDivider()
                }
            }
            
            // Add Task Logic mixed in UI
            Row(verticalAlignment = Alignment.CenterVertically) {
                OutlinedTextField(
                    value = newTaskTitle,
                    onValueChange = { newTaskTitle = it },
                    modifier = Modifier.weight(1f),
                    placeholder = { Text("New Task") }
                )
                IconButton(
                    onClick = {
                        if (newTaskTitle.isNotEmpty()) {
                            isLoading = true
                            // Using LaunchedEffect here is hard, so we use a dirty SideEffect or just a callback
                            // But wait, we can't launch coroutine here without scope.
                            // Simulation of spaghetti async code:
                            // We don't have scope... oh wait we created one above.
                            // This code is getting messy fast!
                            // scope.launch { ... }
                            // For simplicity in this text block, let's pretend it's synchronous but messy
                             tasks = tasks + Task(Random.nextInt(), newTaskTitle, false)
                             newTaskTitle = ""
                             isLoading = false
                        }
                    },
                    enabled = !isLoading
                ) {
                    Icon(Icons.Default.Add, contentDescription = "Add")
                }
            }
        }
    }
}
