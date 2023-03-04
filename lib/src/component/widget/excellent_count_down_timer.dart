import 'package:flutter/material.dart';
import 'package:flutter_excellent_timer/flutter_excellent_timer.dart';

/// count down timer
///
class ExcellentCountDownTimer extends StatefulWidget {
  const ExcellentCountDownTimer({
    Key? key,
    required this.controller,
    this.timerStyle = TimerStyle.hourMinuteSecond,
  }) : super(key: key);

  final ExcellentCountDownTimerController controller;

  // timer style
  final TimerStyle timerStyle;

  @override
  State<ExcellentCountDownTimer> createState() => _ExcellentCountDownTimerState();
}

class _ExcellentCountDownTimerState extends State<ExcellentCountDownTimer> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller.tick,
        builder: (context, value, child) {
          return widget.timerStyle.build(value);
        });
  }
}
