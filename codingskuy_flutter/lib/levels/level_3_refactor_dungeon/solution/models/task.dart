class Task {
  final String title;
  final bool completed;
  final String priority;
  final DateTime createdAt;

  Task({
    required this.title,
    required this.completed,
    required this.priority,
    required this.createdAt,
  });

  Task copyWith({
    String? title,
    bool? completed,
    String? priority,
    DateTime? createdAt,
  }) {
    return Task(
      title: title ?? this.title,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
