import 'package:flutter/cupertino.dart';
import 'package:flutter_excellent_timer/src/tool/duration_handler.dart';

/// count down timer status
///
enum CountDownTimerStatus {
  unknown, // 未知
  isRunning, // 运行状态
  isPaused, // 暂停状态
  isStopped; // 停止状态

  String get toName {
    switch (this) {
      case unknown:
        return 'unknown';
      case isRunning:
        return 'Running';
      case isPaused:
        return 'Paused';
      case isStopped:
        return 'Stopped';
    }
  }
}

/// timer operation
///
enum TimerOperation { start, stop, pause, resume, reset }

/// timer style
enum TimerStyle {
  hourMinuteSecond, // H-M-S
  hourMinute, // H-M
  minuteSecond, // M-S
  hourOnly, // H
  minuteOnly, // M
  secondOnly; // S

  // build timer
  Widget build(Duration duration, {TextStyle? style}) {
    return Text(
      duration.format(this),
      style: style ?? const TextStyle(fontSize: 40),
    );
  }
}
