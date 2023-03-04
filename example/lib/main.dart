import 'package:example/pages/all_operation_demo.dart';
import 'package:example/pages/count_down_timer_demo.dart';
import 'package:example/pages/normal_operation_demo.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // demo item
  Widget demoItem(BuildContext context, String title, Widget demoPage) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => demoPage)),
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          demoItem(context, 'All Operation Demo', const AllOperationDemo()),
          demoItem(context, 'Normal Operation Demo', const NormalOperationDemo()),
          demoItem(context, 'CountDown Timer Demo', const CountDownTimerDemo()),
        ],
      ),
    );
  }
}
