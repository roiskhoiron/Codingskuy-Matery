import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'widgets/add_task_bar.dart';
import 'widgets/filter_bar.dart';
import 'widgets/task_list_item.dart';

class RefactorSolutionScreen extends StatefulWidget {
  const RefactorSolutionScreen({super.key});

  @override
  State<RefactorSolutionScreen> createState() => _RefactorSolutionScreenState();
}

class _RefactorSolutionScreenState extends State<RefactorSolutionScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Task> _tasks = [];
  String _filterStatus = 'all';
  bool _isLoading = false;

  @override
  void dispose() {
    _taskController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    if (_taskController.text.isEmpty) {
      _showMessage('Task cannot be empty');
      return;
    }
    
    setState(() => _isLoading = true);
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _tasks.add(Task(
        title: _taskController.text,
        completed: false,
        priority: 'normal',
        createdAt: DateTime.now(),
      ));
      _taskController.clear();
      _isLoading = false;
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(completed: !_tasks[index].completed);
    });
  }

  void _deleteTask(int index) {
    setState(() => _tasks.removeAt(index));
  }

  void _updatePriority(int index, String priority) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(priority: priority);
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = TaskFilter.apply(_tasks, _filterStatus, _searchController.text);
    final stats = TaskStats.fromTasks(_tasks);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Refactor Solution'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: SearchAndStatsBar(
            searchController: _searchController,
            stats: stats,
            onSearchChanged: () => setState(() {}),
          ),
        ),
      ),
      body: Column(
        children: [
          FilterBar(
            filterStatus: _filterStatus,
            onFilterChanged: (status) => setState(() => _filterStatus = status),
          ),
          Expanded(
            child: TaskListView(
              isLoading: _isLoading,
              tasks: _tasks,
              filteredTasks: filteredTasks,
              onToggleTask: _toggleTask,
              onUpdatePriority: _updatePriority,
              onDeleteTask: _deleteTask,
            ),
          ),
          AddTaskBar(
            controller: _taskController,
            onAddTask: _addTask,
          ),
        ],
      ),
    );
  }
}

class SearchAndStatsBar extends StatelessWidget {
  final TextEditingController searchController;
  final TaskStats stats;
  final VoidCallback onSearchChanged;

  const SearchAndStatsBar({
    super.key,
    required this.searchController,
    required this.stats,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search tasks...',
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => onSearchChanged(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total: ${stats.total} | Done: ${stats.completed} | Pending: ${stats.pending}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (stats.highPriority > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${stats.highPriority} urgent',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class TaskListView extends StatelessWidget {
  final bool isLoading;
  final List<Task> tasks;
  final List<Task> filteredTasks;
  final Function(int) onToggleTask;
  final Function(int, String) onUpdatePriority;
  final Function(int) onDeleteTask;

  const TaskListView({
    super.key,
    required this.isLoading,
    required this.tasks,
    required this.filteredTasks,
    required this.onToggleTask,
    required this.onUpdatePriority,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredTasks.isEmpty) {
      return EmptyTasksView(hasAnyTasks: tasks.isNotEmpty);
    }

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        final originalIndex = tasks.indexOf(task);
        
        return TaskListItem(
          task: task,
          onToggle: () => onToggleTask(originalIndex),
          onUpdatePriority: (priority) => onUpdatePriority(originalIndex, priority),
          onDelete: () => onDeleteTask(originalIndex),
        );
      },
    );
  }
}

class EmptyTasksView extends StatelessWidget {
  final bool hasAnyTasks;

  const EmptyTasksView({super.key, required this.hasAnyTasks});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasAnyTasks ? Icons.search_off : Icons.task_alt,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            hasAnyTasks ? 'No tasks match your filter' : 'No tasks yet',
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
