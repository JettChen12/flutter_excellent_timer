import 'package:flutter/cupertino.dart';
import 'package:flutter_excellent_timer/src/tool/enum.dart';

/// 接口
///
abstract class ExcellentTimerInterface {
  /// 开始
  /// [whenCompleted] 结束倒计时的回调
  void start({void Function()? whenCompleted});

  /// 暂停
  void pause();

  /// 恢复
  void resume();

  /// 停止
  void stop();

  /// 重置
  void reset();

  /// 增加时间
  void add(Duration duration);

  /// 设置时长
  void setDuration(Duration duration);

  /// 销毁控制器
  void dispose();

  /// 获取运行状态
  ValueNotifier<CountDownTimerStatus> get status;

  /// 获取当前时间
  ValueNotifier<Duration> get tick;
}
