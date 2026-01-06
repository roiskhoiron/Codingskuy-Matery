import 'package:flutter/material.dart';

class StateChallengeScreen extends StatefulWidget {
  const StateChallengeScreen({super.key});

  @override
  State<StateChallengeScreen> createState() => _StateChallengeScreenState();
}

class _StateChallengeScreenState extends State<StateChallengeScreen> {
  bool _showEditor = false;

  void _toggleView() {
    setState(() {
      _showEditor = !_showEditor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Challenge'),
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
            color: Colors.yellow.shade100,
            child: const Row(
              children: [
                 Icon(Icons.warning, color: Colors.orange),
                 SizedBox(width: 8),
                 Expanded(
                   child: Text(
                     "Try typing a note, then toggle the view button (top right), then toggle back. What happens to your text?",
                     style: TextStyle(fontSize: 12),
                   ),
                 ),
              ],
            ),
          ),
          Expanded(
            child: _showEditor ? const EditorView() : const ListViewPlaceholder(),
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

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Write your note here...',
              border: OutlineInputBorder(),
            ),
            maxLines: 10,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print('Note saved: ${_controller.text}');
            },
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }
}
