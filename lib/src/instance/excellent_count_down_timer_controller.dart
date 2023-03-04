import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_excellent_timer/src/interface/excellent_timer_interface.dart';
import 'package:flutter_excellent_timer/src/tool/enum.dart';


/// 倒计时控制器
///
class ExcellentCountDownTimerController implements ExcellentTimerInterface {
  ExcellentCountDownTimerController({this.stepDuration = const Duration(seconds: 1)});

  /// 定义间隔时间 默认一秒钟
  Duration stepDuration;

  /// 定义计时器
  Timer? _timer;

  /// 空时长
  static const Duration zeroDuration = Duration(milliseconds: 0);

  /// 定义状态通知器
  final ValueNotifier<CountDownTimerStatus> _status = ValueNotifier<CountDownTimerStatus>(CountDownTimerStatus.unknown);

  /// 开始状态
  bool get isRunning => _status.value == CountDownTimerStatus.isRunning;

  /// 停止状态
  bool get isStopped => _status.value == CountDownTimerStatus.isStopped;

  /// 暂停状态
  bool get isPaused => _status.value == CountDownTimerStatus.isPaused;

  /// 定义当前时间通知器
  final ValueNotifier<Duration> _tick = ValueNotifier<Duration>(zeroDuration);

  /// 定义操作流控制器
  final StreamController<TimerOperation> _timerOperationStream = StreamController<TimerOperation>();

  /// 订阅管理
  StreamSubscription? _timerOperationSub;

  /// 实现当前倒计时状态
  @override
  ValueNotifier<CountDownTimerStatus> get status => _status;

  /// 实现当前时间
  @override
  ValueNotifier<Duration> get tick => _tick;

  /// 暂停
  void _pause() {
    _timer?.cancel();
    _timer = null;
  }

  /// 停止
  void _stop() {
    _timer?.cancel();
    _timer = null;
    _tick.value = zeroDuration;
  }

  @override
  void start({required Duration duration, void Function()? whenCompleted}) {
    // 判定当前状态
    if (isRunning || isPaused) {
      return;
    }

    // 开始时获取总时长
    if (_tick.value == zeroDuration) {
      _tick.value = duration;
    }

    // 开启操作监听
    _timerOperationSub ??= _timerOperationStream.stream.listen((event) {
      if (event == TimerOperation.start || event == TimerOperation.resume) {
        _timer = Timer.periodic(stepDuration, (timer) {
          // 递减
          _tick.value -= stepDuration;
          if (_tick.value.inMilliseconds <= 0) {
            // 销毁倒计时
            stop();
            // 回调结束方法
            whenCompleted?.call();
          }
        });
      } else if (event == TimerOperation.stop) {
        _stop();
      } else if (event == TimerOperation.pause) {
        _pause();
      } else if (event == TimerOperation.reset) {
        _pause();
        _tick.value = duration;
      }
    });

    // 开始
    _timerOperationStream.add(TimerOperation.start);
    // 赋值状态
    _status.value = CountDownTimerStatus.isRunning;
  }

  @override
  void pause() {
    if (isPaused || isStopped) {
      return;
    }
    // 暂停
    _timerOperationStream.add(TimerOperation.pause);
    // 赋值状态
    _status.value = CountDownTimerStatus.isPaused;
  }

  @override
  void resume() {
    if (isRunning || isStopped) {
      return;
    }
    // 重新开始
    _timerOperationStream.add(TimerOperation.resume);
    // 赋值状态
    _status.value = CountDownTimerStatus.isRunning;
  }

  @override
  void stop() {
    if (isStopped) {
      return;
    }
    // 停止
    _timerOperationStream.add(TimerOperation.stop);
    // 赋值状态
    _status.value = CountDownTimerStatus.isStopped;
  }

  @override
  void reset() {
    // 重置
    _timerOperationStream.add(TimerOperation.reset);
    // 赋值状态
    _status.value = CountDownTimerStatus.isStopped;
  }

  @override
  void add(Duration duration) {
    _tick.value += duration;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _tick.dispose();
    _status.dispose();
    _timerOperationSub?.cancel();
    _timerOperationSub = null;
  }
}
