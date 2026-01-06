import '../models/task.dart';

class TaskFilter {
  static List<Task> apply(List<Task> tasks, String filterStatus, String searchQuery) {
    return tasks.where((task) {
      final matchesSearch = task.title.toLowerCase().contains(searchQuery.toLowerCase());
      
      if (filterStatus == 'all') {
        return matchesSearch;
      } else if (filterStatus == 'completed') {
        return matchesSearch && task.completed;
      } else if (filterStatus == 'pending') {
        return matchesSearch && !task.completed;
      } else if (filterStatus == 'high' || filterStatus == 'normal' || filterStatus == 'low') {
        return matchesSearch && task.priority == filterStatus;
      }
      return false;
    }).toList();
  }
}

class TaskStats {
  final int total;
  final int completed;
  final int pending;
  final int highPriority;

  TaskStats({
    required this.total,
    required this.completed,
    required this.pending,
    required this.highPriority,
  });

  factory TaskStats.fromTasks(List<Task> tasks) {
    return TaskStats(
      total: tasks.length,
      completed: tasks.where((t) => t.completed).length,
      pending: tasks.where((t) => !t.completed).length,
      highPriority: tasks.where((t) => t.priority == 'high' && !t.completed).length,
    );
  }
}
