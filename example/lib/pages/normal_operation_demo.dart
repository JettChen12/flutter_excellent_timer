import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_excellent_timer/flutter_excellent_timer.dart';

class NormalOperationDemo extends StatefulWidget {
  const NormalOperationDemo({Key? key}) : super(key: key);

  @override
  State<NormalOperationDemo> createState() => _NormalOperationDemoState();
}

class _NormalOperationDemoState extends State<NormalOperationDemo> {
  final ExcellentCountDownTimerController controller = ExcellentCountDownTimerController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Normal Operation Demo'),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.status,
          builder: (context, value, child) {
            return Visibility(
              visible: controller.isRunning || controller.isPaused,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: const Text('CHOOSE TIME'),
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: FloatingActionButton(
                      onPressed: () => controller.start(
                          duration: const Duration(seconds: 10),
                          whenCompleted: () {
                            print('--------------------isCompleted');
                          }),
                      backgroundColor: CupertinoColors.white,
                      tooltip: 'start',
                      heroTag: 'start',
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.blue,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ValueListenableBuilder(
                      valueListenable: controller.tick,
                      builder: (BuildContext context, value, Widget? child) {
                        return Text(
                          '${value.inSeconds}',
                          style: const TextStyle(fontSize: 50, color: Colors.red),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: controller.stop,
                            tooltip: 'stop',
                            heroTag: 'stop',
                            backgroundColor: CupertinoColors.white,
                            child: const Icon(
                              Icons.stop,
                              color: Colors.blue,
                              size: 32,
                            ),
                          ),
                          Visibility(
                            visible: controller.isPaused,
                            replacement: FloatingActionButton(
                              onPressed: controller.pause,
                              backgroundColor: CupertinoColors.white,
                              tooltip: 'pause',
                              heroTag: 'pause',
                              child: const Icon(
                                Icons.pause,
                                color: Colors.blue,
                                size: 32,
                              ),
                            ),
                            child: FloatingActionButton(
                              onPressed: controller.resume,
                              tooltip: 'resume',
                              heroTag: 'resume',
                              backgroundColor: CupertinoColors.white,
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.blue,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
