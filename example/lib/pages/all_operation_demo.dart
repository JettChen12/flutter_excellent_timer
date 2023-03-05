import 'package:flutter/material.dart';
import 'package:flutter_excellent_timer/flutter_excellent_timer.dart';

class AllOperationDemo extends StatefulWidget {
  const AllOperationDemo({Key? key}) : super(key: key);

  @override
  State<AllOperationDemo> createState() => _AllOperationDemoState();
}

class _AllOperationDemoState extends State<AllOperationDemo> {
  final ExcellentCountDownTimerController controller = ExcellentCountDownTimerController(initDuration: const Duration(minutes: 10));

  void _start() {
    controller.start(whenCompleted: () {
      print('--------------------isCompleted');
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Operation Demo'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: controller.tick,
            builder: (BuildContext context, value, Widget? child) {
              return Text(
                '${value.inSeconds}',
                style: const TextStyle(fontSize: 50, color: Colors.red),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: controller.status,
            builder: (context, value, child) {
              return Text('CurrentStatus: ${value.toName}');
            },
          )
        ],
      )),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: controller.status,
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: _start,
                backgroundColor: value == CountDownTimerStatus.isRunning ? Colors.yellow : Colors.blue,
                tooltip: 'start',
                heroTag: 'start',
                child: const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: controller.pause,
                backgroundColor: value == CountDownTimerStatus.isPaused ? Colors.yellow : Colors.blue,
                tooltip: 'pause',
                heroTag: 'pause',
                child: const Icon(Icons.pause),
              ),
              FloatingActionButton(
                onPressed: controller.resume,
                tooltip: 'resume',
                heroTag: 'resume',
                child: const Icon(Icons.double_arrow),
              ),
              FloatingActionButton(
                onPressed: controller.stop,
                backgroundColor: value == CountDownTimerStatus.isStopped ? Colors.yellow : Colors.blue,
                tooltip: 'stop',
                heroTag: 'stop',
                child: const Icon(Icons.stop),
              ),
              FloatingActionButton(
                onPressed: controller.reset,
                tooltip: 'reset',
                heroTag: 'reset',
                child: const Icon(Icons.refresh),
              ),
              FloatingActionButton(
                onPressed: () => controller.add(const Duration(seconds: 5)),
                tooltip: 'add',
                heroTag: 'add',
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
