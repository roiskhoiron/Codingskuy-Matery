package game.codingskuy_kotlin.levels.level3

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import kotlin.random.Random

// Logic is separated into a ViewModel
class TaskViewModel : ViewModel() {
    private val _tasks = MutableStateFlow<List<Task>>(emptyList())
    private val _filter = MutableStateFlow(TaskFilter.All)
    private val _isLoading = MutableStateFlow(false)
    
    val isLoading: StateFlow<Boolean> = _isLoading
    val filter: StateFlow<TaskFilter> = _filter
    
    // Combining flows to derive UI state automatically
    val filteredTasks: StateFlow<List<Task>> = combine(_tasks, _filter) { tasks, filter ->
        when (filter) {
            TaskFilter.All -> tasks
            TaskFilter.Pending -> tasks.filter { !it.isCompleted }
            TaskFilter.Completed -> tasks.filter { it.isCompleted }
        }
    }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())
    
    fun addTask(title: String) {
        if (title.isBlank()) return
        
        viewModelScope.launch {
            _isLoading.value = true
            delay(500) // Simulate network
            val newTask = Task(id = Random.nextInt().toString(), title = title)
            _tasks.value = _tasks.value + newTask
            _isLoading.value = false
        }
    }
    
    fun toggleTask(taskId: String) {
        _tasks.value = _tasks.value.map { 
            if (it.id == taskId) it.copy(isCompleted = !it.isCompleted) else it 
        }
    }
    
    fun setFilter(filter: TaskFilter) {
        _filter.value = filter
    }
}

enum class TaskFilter { All, Pending, Completed }
