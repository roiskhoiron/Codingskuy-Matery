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
import androidx.lifecycle.viewmodel.compose.viewModel

@Composable
fun RefactorSolutionScreen(
    onBack: () -> Unit,
    viewModel: TaskViewModel = viewModel { TaskViewModel() } // In proper DI this would be injected
) {
    val tasks by viewModel.filteredTasks.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()
    val currentFilter by viewModel.filter.collectAsState()
    
    Scaffold(
        topBar = { TopAppBar(title = { Text("Refactor Solution") }, navigationIcon = { Button(onClick = onBack) { Text("Back") } }) }
    ) { padding ->
        Column(modifier = Modifier.padding(padding).padding(16.dp)) {
            
            // Sub-Composable for Filtering
            TaskFilterBar(currentFilter = currentFilter, onFilterSelected = viewModel::setFilter)
            
            if (isLoading) LinearProgressIndicator(modifier = Modifier.fillMaxWidth())
            
            // Sub-Composable for List
            TaskList(
                tasks = tasks,
                onToggleTask = { viewModel.toggleTask(it.id) },
                modifier = Modifier.weight(1f)
            )
            
            // Sub-Composable for Input
            TaskInput(onAddTask = viewModel::addTask, enabled = !isLoading)
        }
    }
}

@Composable
fun TaskFilterBar(currentFilter: TaskFilter, onFilterSelected: (TaskFilter) -> Unit) {
    Row(modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp), horizontalArrangement = Arrangement.SpaceEvenly) {
        TaskFilter.entries.forEach { filter ->
            FilterChip(
                selected = currentFilter == filter,
                onClick = { onFilterSelected(filter) },
                label = { Text(filter.name) }
            )
        }
    }
}

@Composable
fun TaskList(tasks: List<Task>, onToggleTask: (Task) -> Unit, modifier: Modifier = Modifier) {
    LazyColumn(modifier = modifier) {
        items(tasks, key = { it.id }) { task ->
            TaskRow(task = task, onToggle = { onToggleTask(task) })
            HorizontalDivider()
        }
    }
}

@Composable
fun TaskRow(task: Task, onToggle: () -> Unit) {
    Row(
        modifier = Modifier.fillMaxWidth().padding(8.dp).clickable(onClick = onToggle),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Checkbox(checked = task.isCompleted, onCheckedChange = null)
        Text(
            text = task.title,
            textDecoration = if (task.isCompleted) TextDecoration.LineThrough else null,
            color = if (task.isCompleted) Color.Gray else Color.Unspecified
        )
    }
}

@Composable
fun TaskInput(onAddTask: (String) -> Unit, enabled: Boolean) {
    var text by remember { mutableStateOf("") }
    Row(verticalAlignment = Alignment.CenterVertically) {
        OutlinedTextField(
            value = text,
            onValueChange = { text = it },
            modifier = Modifier.weight(1f),
            placeholder = { Text("New Task") }
        )
        IconButton(
            onClick = {
                if (text.isNotBlank()) {
                    onAddTask(text)
                    text = ""
                }
            },
            enabled = enabled
        ) {
            Icon(Icons.Default.Add, contentDescription = "Add")
        }
    }
}
