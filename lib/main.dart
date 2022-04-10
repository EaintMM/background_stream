import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream _myStream = Stream.periodic(Duration(seconds: 1), (int count) {
    return count;
  });
  late StreamSubscription _sub;
  int _count = 0;
  Color _bgColor = Colors.blueGrey;

  @override
  void initState() {
    _sub = _myStream.listen((event) {
      setState(() {
        _count = event;
        // set background color to a random color
        _bgColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        title: const Text('Background Stream'),
      ),
      body: Center(
        child: Text(
          _count.toString(),
          style: const TextStyle(fontSize: 150, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.stop,
            size: 30,
          ),
          onPressed: () => _sub.cancel()),
    );
  }
}
