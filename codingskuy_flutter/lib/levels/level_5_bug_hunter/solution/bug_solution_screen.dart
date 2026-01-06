import 'package:flutter/material.dart';
import 'dart:async';

class BugSolutionScreen extends StatefulWidget {
  const BugSolutionScreen({super.key});

  @override
  State<BugSolutionScreen> createState() => _BugSolutionScreenState();
}

class _BugSolutionScreenState extends State<BugSolutionScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  bool _autoRefresh = false;
  Timer? _refreshTimer;

  @override
  void dispose() {
    _messageController.dispose();
    _refreshTimer?.cancel(); // Fix: Cancel timer on dispose
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final newMessages = [
      'Welcome to the board',
      'Message at ${DateTime.now().second}s',
    ];
    
    // Fix: Check mounted before setState
    if (mounted) {
      setState(() {
        _messages = newMessages;
      });
    }
  }

  Future<void> _postMessage() async {
    if (_messageController.text.isEmpty) return;

    final message = _messageController.text;
    _messageController.clear();

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _messages.insert(0, message);
      });
    }

    if (_autoRefresh && mounted) {
      await _fetchMessages();
    }
  }

  void _toggleAutoRefresh() {
    setState(() {
      _autoRefresh = !_autoRefresh;
    });

    if (_autoRefresh) {
      _startAutoRefresh();
    } else {
      _stopAutoRefresh();
    }
  }

  // Fix: Use Timer for controlled loop that can be cancelled
  void _startAutoRefresh() {
    _stopAutoRefresh(); // Ensure no duplicate timers
    _refreshTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && _autoRefresh) {
        _fetchMessages();
      }
    });
  }

  void _stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Board (Fixed)'),
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
            color: Colors.green.shade50,
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Safe to navigate away! Timers are cancelled and async gaps are checked.",
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
