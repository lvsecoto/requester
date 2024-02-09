import 'dart:async';

import 'package:flutter/material.dart';
import 'package:requester_client/requester_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _counterController = StreamController<int>()..add(0);
  late Stream<int> _counterStream;

  @override
  void initState() {
    super.initState();
    _counterStream = _counterController.stream.asBroadcastStream();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _counterController.sink.add(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RequesterClientWidget(
      clientInfoProvider: _counterStream.map(
        (counter) => {
          'counter': counter.toString(),
        },
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
