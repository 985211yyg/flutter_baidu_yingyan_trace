import 'package:flutter_baidu_yingyan_trace/src/callback/trace_callback.dart';
import 'package:flutter_baidu_yingyan_trace/src/interface/trace_interface.dart';
import 'package:flutter_baidu_yingyan_trace/src/manager/base_manager.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/trace/service_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/trace/trace.dart';

class TraceManager extends BaseManager implements TraceInterface {
  @override
  Future<bool> configServerInfo(ServiceOption serviceOption) async {
    return await this.baiduYingYanMethodChannel.configServerInfo(serviceOption);
  }

  @override
  Future<bool> setCacheSize({
    required int size,
    TraceCallback? traceCallback,
  }) async {
    return await this.baiduYingYanMethodChannel.setCacheSize(
          size: size,
          traceCallback: traceCallback,
        );
  }

  @override
  Future<bool> setInterval({
    required int gatherInterval,
    required int packInterval,
    TraceCallback? traceCallback,
  }) async {
    return await this.baiduYingYanMethodChannel.setInterval(
        gatherInterval: gatherInterval,
        packInterval: packInterval,
        traceCallback: traceCallback);
  }

  Future<bool> setLocationMode({
    required int gatherInterval,
    required int packInterval,
    TraceCallback? traceCallback,
  }) async {
    return await this.baiduYingYanMethodChannel.setInterval(
        gatherInterval: gatherInterval,
        packInterval: packInterval,
        traceCallback: traceCallback);
  }

  @override
  Future<bool> startGather({TraceCallback? traceCallback}) async {
    return await this.baiduYingYanMethodChannel.startGather(
          traceCallback: traceCallback,
        );
  }

  @override
  Future<bool> startTraceService({
    required Trace trace,
    TraceCallback? traceCallback,
  }) async {
    return await this.baiduYingYanMethodChannel.startTraceService(
          trace: trace,
          traceCallback: traceCallback,
        );
  }

  @override
  Future<bool> stopGather({TraceCallback? traceCallback}) async {
    return await this.baiduYingYanMethodChannel.stopGather(
          traceCallback: traceCallback,
        );
  }

  @override
  Future<bool> stopTraceService({
    required Trace trace,
    TraceCallback? traceCallback,
  }) async {
    return await this.baiduYingYanMethodChannel.stopTraceService(
          trace: trace,
          traceCallback: traceCallback,
        );
  }

  Future<void> release() async {
    return await this.baiduYingYanMethodChannel.release();
  }
}
