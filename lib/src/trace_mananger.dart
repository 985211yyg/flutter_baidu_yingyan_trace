import 'package:flutter/services.dart';

//("result", false)
typedef EventHandler = Function(dynamic eventData);

class TraceManager {
  // 初始化
  static final MethodChannel _channel =
      MethodChannel('com.reemii.driver.channel.bamap');
  static final EventChannel _eventChannel =
      EventChannel('com.reemii.driver.channel.bamap.event');
  static final TraceManager _instance = TraceManager._internal();

  // 工厂模式
  factory TraceManager() => _getInstance();

  static TraceManager _getInstance() {
    return _instance;
  }

  static TraceManager get instance => _getInstance();

  //需要在最开始初始化！！！！！
  void addEventHandler(EventHandler eventHandler) {
    _eventChannel.receiveBroadcastStream().listen((data) {
      eventHandler(data);
    });
  }

  TraceManager._internal() {}

  //初始化轨迹追踪
  void initBdLocation() async {
    await _channel.invokeMethod('initBdLocation');
  }

  Future<String> initTrace(
      {required String traceId, required String staffId}) async {
    return await _channel
        .invokeMethod("initTrace", {'traceId': traceId, 'staffId': staffId});
  }

  //开启鹰眼服务
  void startTrace() async {
    await _channel.invokeMethod("startTrace");
  }

  //停止鹰眼服务
  void stopTrace() async {
    await _channel.invokeMethod("stopTrace");
  }

  //开始收集
  Future<bool> startGatherTrace() async {
    return await _channel.invokeMethod("startGather");
  }

  //停止收集
  void stopGatherTrace() async {
    return await _channel.invokeMethod("stopGather");
  }
}
