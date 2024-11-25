import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A stream that emits the current date and time every second
Stream<String> timeStream() async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield DateTime.now().toString();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Providing the timeStream as a StreamProvider
        StreamProvider<String>(
          create: (_) => timeStream(),
          initialData: 'Loading...',
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream in Provider Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stream in Provider Example',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 100,
                color: Colors.blue.shade700,
              ),
              const SizedBox(height: 20),
              Consumer<String>(
                builder: (context, time, child) {
                  return Text(
                    time,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
