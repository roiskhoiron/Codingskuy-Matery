import 'package:flutter/material.dart';

class AddTaskBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAddTask;

  const AddTaskBar({super.key, required this.controller, required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Add a new task...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => onAddTask(),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onAddTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
