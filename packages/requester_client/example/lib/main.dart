import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:requester_client/requester_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RequesterClientWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  late final infoProvider =
      RequesterClientController.of(context).clientInfoProvider;
  late final logProvider = RequesterClientController.of(context).logProvider;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    dio.interceptors.addAll([
      RequesterLogDioInterceptor(logProvider),
    ]);
    infoProvider.set('counter', _counter.toString());
    infoProvider.on('counter', (value) {
      _counter = int.tryParse(value) ?? _counter;
      setState(() {});
      return _counter.toString();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      infoProvider.set('counter', _counter.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                dio.get(
                  'https://petstore3.swagger.io/api/v3/pet/findByStatus?status=available',
                  queryParameters: {
                    'meta': '2'
                  }
                );
              },
              child: const Text('GET'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                dio.get(
                    'https://petstore3.swagger.io/api/v3/pet/findByStatus?status=availa',
                );
              },
              child: const Text('GET(Error)'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
