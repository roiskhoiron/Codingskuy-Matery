import 'package:flutter/material.dart';

class StateSolutionScreen extends StatefulWidget {
  const StateSolutionScreen({super.key});

  @override
  State<StateSolutionScreen> createState() => _StateSolutionScreenState();
}

class _StateSolutionScreenState extends State<StateSolutionScreen> {
  bool _showEditor = false;
  // Solution: State is lifted up to the parent
  final TextEditingController _controller = TextEditingController();

  void _toggleView() {
    setState(() {
      _showEditor = !_showEditor;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Solution'),
        actions: [
          IconButton(
            icon: Icon(_showEditor ? Icons.list : Icons.edit),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.green.shade100,
            child: const Row(
              children: [
                 Icon(Icons.check_circle, color: Colors.green),
                 SizedBox(width: 8),
                 Expanded(
                   child: Text(
                     "Type a note, toggle view, toggle back. Your text survives because the state is owned by the parent!",
                     style: TextStyle(fontSize: 12),
                   ),
                 ),
              ],
            ),
          ),
          Expanded(
            child: _showEditor 
                ? EditorView(controller: _controller) 
                : const ListViewPlaceholder(),
          ),
        ],
      ),
    );
  }
}

class ListViewPlaceholder extends StatelessWidget {
  const ListViewPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Note list view (Generic Placeholder)'),
    );
  }
}

class EditorView extends StatelessWidget {
  final TextEditingController controller;

  const EditorView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Write your note here...',
              border: OutlineInputBorder(),
            ),
            maxLines: 10,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print('Note saved: ${controller.text}');
            },
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }
}
