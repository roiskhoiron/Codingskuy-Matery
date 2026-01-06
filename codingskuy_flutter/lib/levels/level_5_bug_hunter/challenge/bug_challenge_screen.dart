import 'package:flutter/material.dart';

class BugChallengeScreen extends StatefulWidget {
  const BugChallengeScreen({super.key});

  @override
  State<BugChallengeScreen> createState() => _BugChallengeScreenState();
}

class _BugChallengeScreenState extends State<BugChallengeScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  bool _autoRefresh = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final newMessages = [
      'Welcome to the board',
      'Message at ${DateTime.now().second}s',
    ];
    
    // Intentional flaw: setState called after async gap without checking mounted
    // This will throw error if user navigates away before this completes
    setState(() {
      _messages = newMessages;
    });
  }

  void _postMessage() async {
    if (_messageController.text.isEmpty) return;

    final message = _messageController.text;
    _messageController.clear();

    await Future.delayed(const Duration(milliseconds: 500));

    // Intentional flaw: Race condition possible if refresh happens same time
    setState(() {
      _messages.insert(0, message);
    });

    if (_autoRefresh) {
      _fetchMessages();
    }
  }

  void _toggleAutoRefresh() {
    setState(() {
      _autoRefresh = !_autoRefresh;
    });

    if (_autoRefresh) {
      _startAutoRefresh();
    }
  }

  void _startAutoRefresh() async {
    // Intentional flaw: Infinite loop that doesn't respect disposal
    // If user leaves screen with auto-refresh on, this keeps running in background
    // and trying to call setState on a disposed widget!
    while (_autoRefresh) {
      await Future.delayed(const Duration(seconds: 3));
      if (_autoRefresh) {
        _fetchMessages();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Board (Buggy)'),
        actions: [
          IconButton(
            icon: Icon(_autoRefresh ? Icons.refresh : Icons.refresh_outlined),
            onPressed: _toggleAutoRefresh,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red.shade50,
            child: const Row(
              children: [
                Icon(Icons.bug_report, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Enable refresh loop, then quickly go back. Check your debug console for errors!",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _messages.isEmpty
                ? const Center(child: Text('No messages'))
                : ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          title: Text(_messages[index]),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _postMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
