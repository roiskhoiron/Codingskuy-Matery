import 'package:flutter/material.dart';

class RebuildChallengeScreen extends StatefulWidget {
  const RebuildChallengeScreen({super.key});

  @override
  State<RebuildChallengeScreen> createState() => _RebuildChallengeScreenState();
}

class _RebuildChallengeScreenState extends State<RebuildChallengeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Challenge: HomeScreen build called');
    final currentTime = DateTime.now().toString();
    
    return Scaffold(
      appBar: AppBar(
        title: HeaderWidget(time: currentTime),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubtitleWidget(counter: _counter),
            const SizedBox(height: 20),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Increment'),
            ),
            const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Check your debug console! Notice how many widgets rebuild when you click increment, even ones that don't need to.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                )
            )
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String time;
  
  const HeaderWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    print('Challenge: HeaderWidget build called');
    return const Text('Counter Dashboard');
  }
}

class SubtitleWidget extends StatelessWidget {
  final int counter;
  
  const SubtitleWidget({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    print('Challenge: SubtitleWidget build called');
    // final isEven = counter % 2 == 0; // Unused computation
    return Text(
      'Current count:',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
