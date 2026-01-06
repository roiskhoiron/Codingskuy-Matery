import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final Function(String) onUpdatePriority;
  final VoidCallback onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onUpdatePriority,
    required this.onDelete,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case 'high': return Colors.red;
      case 'normal': return Colors.orange;
      case 'low': return Colors.green;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Checkbox(value: task.completed, onChanged: (value) => onToggle()),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none,
            color: task.completed ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: PriorityIndicator(priority: task.priority, color: _getPriorityColor()),
        trailing: TaskMenu(
          onUpdatePriority: onUpdatePriority,
          onDelete: onDelete,
        ),
      ),
    );
  }
}

class PriorityIndicator extends StatelessWidget {
  final String priority;
  final Color color;

  const PriorityIndicator({super.key, required this.priority, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(priority, style: TextStyle(color: color)),
      ],
    );
  }
}

class TaskMenu extends StatelessWidget {
  final Function(String) onUpdatePriority;
  final VoidCallback onDelete;

  const TaskMenu({super.key, required this.onUpdatePriority, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'delete') {
          onDelete();
        } else {
          onUpdatePriority(value);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'high', child: Text('High Priority')),
        const PopupMenuItem(value: 'normal', child: Text('Normal Priority')),
        const PopupMenuItem(value: 'low', child: Text('Low Priority')),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
    );
  }
}
