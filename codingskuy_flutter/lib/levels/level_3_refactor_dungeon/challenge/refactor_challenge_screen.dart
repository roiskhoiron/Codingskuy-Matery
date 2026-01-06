import 'package:flutter/material.dart';

class RefactorChallengeScreen extends StatefulWidget {
  const RefactorChallengeScreen({super.key});

  @override
  State<RefactorChallengeScreen> createState() => _RefactorChallengeScreenState();
}

class _RefactorChallengeScreenState extends State<RefactorChallengeScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];
  String _filterStatus = 'all';
  bool _isLoading = false;

  @override
  void dispose() {
    _taskController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addTask() async {
    if (_taskController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task cannot be empty')),
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _tasks.add({
        'title': _taskController.text,
        'completed': false,
        'priority': 'normal',
        'createdAt': DateTime.now(),
      });
      _taskController.clear();
      _isLoading = false;
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _updatePriority(int index, String priority) {
    setState(() {
      _tasks[index]['priority'] = priority;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = _searchController.text.toLowerCase();
    
    List<Map<String, dynamic>> filteredTasks = _tasks.where((task) {
      final matchesSearch = task['title'].toString().toLowerCase().contains(searchQuery);
      
      if (_filterStatus == 'all') {
        return matchesSearch;
      } else if (_filterStatus == 'completed') {
        return matchesSearch && task['completed'] == true;
      } else if (_filterStatus == 'pending') {
        return matchesSearch && task['completed'] == false;
      } else if (_filterStatus == 'high') {
        return matchesSearch && task['priority'] == 'high';
      } else if (_filterStatus == 'normal') {
        return matchesSearch && task['priority'] == 'normal';
      } else if (_filterStatus == 'low') {
        return matchesSearch && task['priority'] == 'low';
      }
      return false;
    }).toList();

    final completedCount = _tasks.where((t) => t['completed'] == true).length;
    final pendingCount = _tasks.where((t) => t['completed'] == false).length;
    final highPriorityCount = _tasks.where((t) => t['priority'] == 'high' && t['completed'] == false).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager (Messy Implementation)'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search tasks...',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total: ${_tasks.length} | Done: $completedCount | Pending: $pendingCount',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (highPriorityCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$highPriorityCount urgent',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Filter: '),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('All'),
                  selected: _filterStatus == 'all',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _filterStatus = 'all';
                      });
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Completed'),
                  selected: _filterStatus == 'completed',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _filterStatus = 'completed';
                      });
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Pending'),
                  selected: _filterStatus == 'pending',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _filterStatus = 'pending';
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredTasks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _tasks.isEmpty ? Icons.task_alt : Icons.search_off,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _tasks.isEmpty ? 'No tasks yet' : 'No tasks match your filter',
                              style: const TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          final originalIndex = _tasks.indexOf(task);
                          
                          Color priorityColor = Colors.grey;
                          if (task['priority'] == 'high') {
                            priorityColor = Colors.red;
                          } else if (task['priority'] == 'normal') {
                            priorityColor = Colors.orange;
                          } else if (task['priority'] == 'low') {
                            priorityColor = Colors.green;
                          }

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: ListTile(
                              leading: Checkbox(
                                value: task['completed'],
                                onChanged: (value) {
                                  _toggleTask(originalIndex);
                                },
                              ),
                              title: Text(
                                task['title'],
                                style: TextStyle(
                                  decoration: task['completed']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: task['completed'] ? Colors.grey : Colors.black,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: priorityColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    task['priority'],
                                    style: TextStyle(color: priorityColor),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_vert),
                                    onSelected: (value) {
                                      if (value == 'high' || value == 'normal' || value == 'low') {
                                        _updatePriority(originalIndex, value);
                                      } else if (value == 'delete') {
                                        _deleteTask(originalIndex);
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'high',
                                        child: Text('High Priority'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'normal',
                                        child: Text('Normal Priority'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'low',
                                        child: Text('Low Priority'),
                                      ),
                                      const PopupMenuDivider(),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Container(
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
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
