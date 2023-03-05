import 'package:flutter/material.dart';

/// timer style
enum TimerStyle {
  hourMinuteSecondMilliSecond, // H-M-S-MS
  hourMinuteSecond, // H-M-S
  hourMinute, // H-M
  minuteSecond, // M-S
  minuteSecondMilliSecond, // M-S-MS
  hourOnly, // H
  minuteOnly, // M
  secondOnly, // S
  milliSecondOnly; // MS

  // build timer
  Widget build(Duration duration, {TextStyle? style}) {
    return Text(
      duration.format(this),
      style: style ?? const TextStyle(fontSize: 40),
    );
  }
}

/// extension
extension DurationExtension on Duration {
  String format(TimerStyle style) {
    final totalMilliSeconds = inMilliseconds;
    final hours = totalMilliSeconds ~/ 3600000;
    final minutes = (totalMilliSeconds % 3600000) ~/ 60000;
    final seconds = (totalMilliSeconds % 60000) ~/ 1000;
    final milliSeconds = totalMilliSeconds % 1000 ~/ 10;
    final showHours = hours >= 0 && hours < 10 ? '0$hours' : hours.toString();
    final showMinutes = minutes >= 0 && minutes < 10 ? '0$minutes' : minutes.toString();
    final showSeconds = seconds >= 0 && seconds < 10 ? '0$seconds' : seconds.toString();
    final showMilliSeconds = milliSeconds >= 0 && milliSeconds < 10 ? '0$milliSeconds' : milliSeconds.toString();

    switch (style) {
      case TimerStyle.hourMinuteSecondMilliSecond:
        return '$showHours:$showMinutes:$showSeconds:$showMilliSeconds';
      case TimerStyle.hourMinuteSecond:
        return '$showHours:$showMinutes:$showSeconds';
      case TimerStyle.hourMinute:
        return '$showHours:$showMinutes';
      case TimerStyle.minuteSecond:
        return '$showMinutes:$showSeconds';
      case TimerStyle.minuteSecondMilliSecond:
        return '$showMinutes:$showSeconds:$showMilliSeconds';
      case TimerStyle.hourOnly:
        return showHours;
      case TimerStyle.minuteOnly:
        return showMinutes;
      case TimerStyle.secondOnly:
        return showSeconds;
      case TimerStyle.milliSecondOnly:
        return showMilliSeconds;
      default:
        return '$showHours:$showMinutes:$showSeconds';
    }
  }
}
