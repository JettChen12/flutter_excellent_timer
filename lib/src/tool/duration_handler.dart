import 'package:flutter_excellent_timer/flutter_excellent_timer.dart';

extension DurationExtension on Duration {
  String format(TimerStyle style) {
    final totalMilliSeconds = inMilliseconds;
    final hours = totalMilliSeconds ~/ 3600000;
    final minutes = (totalMilliSeconds % 3600000) ~/ 60000;
    final seconds = (totalMilliSeconds % 60000) ~/ 1000;
    // final milliSeconds = 0; // TODO
    switch (style) {
      case TimerStyle.hourMinuteSecond:
        return '$hours:$minutes:$seconds';
      case TimerStyle.hourMinute:
        return '$hours:$minutes';
      case TimerStyle.minuteSecond:
        return '$minutes:$seconds';
      case TimerStyle.hourOnly:
        return '$hours';
      case TimerStyle.minuteOnly:
        return '$minutes';
      case TimerStyle.secondOnly:
        return '$seconds';
    }
  }
}
