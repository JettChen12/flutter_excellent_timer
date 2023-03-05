import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_excellent_timer/flutter_excellent_timer.dart';

class CountDownTimerDemo extends StatefulWidget {
  const CountDownTimerDemo({Key? key}) : super(key: key);

  @override
  State<CountDownTimerDemo> createState() => _CountDownTimerDemoState();
}

class _CountDownTimerDemoState extends State<CountDownTimerDemo> {
  final ExcellentCountDownTimerController _controller = ExcellentCountDownTimerController(initDuration: const Duration(hours: 2));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Count Down Timer Demo'),
      ),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: _controller.status,
            builder: (context, value, child) => Visibility(
                  visible: _controller.isRunning || _controller.isPaused,
                  replacement: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () => _controller.setDuration(const Duration(minutes: 10)),
                          child: const Text('set duration'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: FloatingActionButton(
                              onPressed: () => _controller.start(whenCompleted: () {
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
                            )),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: ExcellentCountDownTimer(
                            controller: _controller,
                            timerStyle: TimerStyle.hourMinuteSecondMilliSecond,
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                onPressed: _controller.stop,
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
                                visible: _controller.isPaused,
                                replacement: FloatingActionButton(
                                  onPressed: _controller.pause,
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
                                  onPressed: _controller.resume,
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
                )),
      ),
    );
  }
}
