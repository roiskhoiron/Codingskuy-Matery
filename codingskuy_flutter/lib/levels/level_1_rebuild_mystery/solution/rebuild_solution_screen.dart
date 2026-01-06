import 'package:flutter/material.dart';

class RebuildSolutionScreen extends StatefulWidget {
  const RebuildSolutionScreen({super.key});

  @override
  State<RebuildSolutionScreen> createState() => _RebuildSolutionScreenState();
}

class _RebuildSolutionScreenState extends State<RebuildSolutionScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Solution: HomeScreen build called');
    
    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SubtitleWidget(),
            const SizedBox(height: 20),
            CounterDisplay(counter: _counter),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Increment'),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Check the console now. Only necessary widgets rebuild.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
              )
            )
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('Solution: HeaderWidget build called');
    return const Text('Counter Dashboard');
  }
}

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('Solution: SubtitleWidget build called');
    return const Text(
      'Current count:',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  final int counter;
  
  const CounterDisplay({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    print('Solution: CounterDisplay build called');
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
