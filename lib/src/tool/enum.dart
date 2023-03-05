

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
