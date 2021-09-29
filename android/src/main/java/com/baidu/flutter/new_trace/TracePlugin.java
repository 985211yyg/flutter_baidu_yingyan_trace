package com.baidu.flutter.new_trace;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.baidu.trace.api.track.DistanceResponse;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Author: yyg
 * Date: 2021/9/29 12:51 下午
 * Description:
 */
class TracePlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {
    public static final String TAG = TracePlugin.class.getSimpleName();

    public static final String CHANNEL_NAME = "com.reemii.driver.channel.bamap";
    public static final String EVENT_CHANNEL = "com.reemii.driver.channel.bamap.event";

    private MethodChannel mMethodChannel;
    private EventChannel.EventSink mEventSink;
    private FlutterPluginBinding mFlutterPluginBinding;

    private TraceManager mTraceManager;

    public TracePlugin() {
        Log.e(TAG, "TracePlugin:初始化 ");
    }

    //新版本使用:注入到插件表中是自动调用
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        mFlutterPluginBinding = flutterPluginBinding;
        setupChannel(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext());
        // 2. 初始化轨迹工具类
        mTraceManager = new TraceManager(flutterPluginBinding.getApplicationContext());
    }

    //FlutterEngine调用
    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        teardownChannel();
        // 2. 释放轨迹相关
        mTraceManager.release();
    }

    private void setupChannel(BinaryMessenger messenger, Context context) {
        new EventChannel(messenger, EVENT_CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                mEventSink = events;
            }

            @Override
            public void onCancel(Object arguments) {
            }
        });
        mMethodChannel = new MethodChannel(messenger, CHANNEL_NAME);
        mMethodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall call, final MethodChannel.Result result) {
        Log.e(TAG, "onMethodCall: " + call.method);
        switch (call.method) {
            case "initTrace":
                //初始化服务
                Map<String, String> params = (Map<String, String>) call.arguments;
                String staffId = params.get("staffId");
                String traceId = params.get("traceId");
                //初始化鹰眼轨迹服务
                mTraceManager.initTrace(new TraceConfig(staffId,
                        Long.parseLong(traceId),
                        3,
                        6,
                        mFlutterPluginBinding.getApplicationContext()));
                result.success(params.toString());
                break;

            case "startTrace":
                //开启轨迹服务
                mTraceManager.startTrace(new TraceConfig.ITraceService.TraceCallback() {
                    @Override
                    public void onTraceOpenSuccess() {
                        Log.e(TAG, "onTraceOpenSuccess: ");
                        Map<String, Object> data = new HashMap<>();
                        data.put("result", true);
                        if (mEventSink != null) mEventSink.success(data);
                    }

                    @Override
                    public void onTraceOpenFailed(int code, String msg) {
                        Log.e(TAG, "onTraceOpenFailed: " + code + msg);
                        Map<String, Object> data = new HashMap<>();
                        data.put("result", false);
                        if (mEventSink != null) mEventSink.success(data);
                    }
                });
                break;
            case "startGather":
                //开始收集
                mTraceManager.startGather(new TraceConfig.ITraceService.GatherCallback() {
                    @Override
                    public void onGatherSuccess() {
                        Log.e(TAG, "onGatherSuccess: ");
                        if (result == null) return;
                        try {
                            result.success(true);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                    @Override
                    public void onGatherFailed(int code, String msg) {
                        Log.e(TAG, "onGatherFailed: ");
                        if (result == null) return;
                        try {
                            result.success(false);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                });
                break;
            case "stopTrace":
                //停止轨迹服务
                mTraceManager.stopTrace();
                break;
            case "stopGather":
                //停止轨迹收集
                mTraceManager.stopGather();
                break;

            default:
                result.notImplemented();
                break;
        }
    }


    //销毁
    private void teardownChannel() {
        mMethodChannel.setMethodCallHandler(null);
        mMethodChannel = null;
    }

}
