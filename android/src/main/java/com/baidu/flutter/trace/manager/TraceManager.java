package com.baidu.flutter.trace.manager;

import java.util.HashMap;
import java.util.Map;

import com.baidu.flutter.trace.Constant;
import com.baidu.flutter.trace.model.PushResult;
import com.baidu.flutter.trace.model.TraceOption;
import com.baidu.flutter.trace.utils.BLog;
import com.baidu.flutter.trace.utils.DataConvertUtil;
import com.baidu.trace.model.OnTraceListener;
import com.baidu.trace.model.PushMessage;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Copyright (C) 2019 Baidu, Inc. All Rights Reserved.
 */
public class TraceManager extends BaseManager {

    TraceManager(LBSTraceController lbsTraceController) {
        super(lbsTraceController);
    }

    @Override
    public void handleMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call == null || mLBSTraceController == null) {
            result.success(false);
            return;
        }

        switch (call.method) {
            case Constant.TraceMethodId.START_TRACE_SERVICE:
                startTrace(call, result);
                break;
            case Constant.TraceMethodId.STOP_TRACE_SERVICE:
                stopTrace(call, result);
                break;

            case Constant.TraceMethodId.START_GATHER:
                startGather(result);
                break;

            case Constant.TraceMethodId.STOP_GATHER:
                stopGather(result);
                break;

            case Constant.TraceMethodId.SET_INTERVAL:
                setInterval(call, result);
                break;

            case Constant.TraceMethodId.SET_CACHE_SIZE:
                setCacheSize(call, result);
                break;

            default:
                break;
        }
    }

    private void startTrace(MethodCall call, MethodChannel.Result result) {
        if (call == null || call.arguments == null || mLBSTraceController == null
                || mLBSTraceController.getLBSTraceClient() == null) {
            result.success(false);
            return;
        }

        TraceOption traceOption =
                (TraceOption) DataConvertUtil.mapToObject((Map<String, Object>) call.arguments,
                        TraceOption.class);

        if (traceOption == null) {
            result.success(false);
            return;
        }

        mLBSTraceController.getLBSTraceClient().startTrace(traceOption.toTrace(),
                new PluginOnTraceListener());

        result.success(true);

    }

    private void stopTrace(MethodCall call, MethodChannel.Result result) {
        if (call == null || call.arguments == null || mLBSTraceController == null
                || mLBSTraceController.getLBSTraceClient() == null) {
            result.success(false);
            return;
        }

        TraceOption traceOption =
                (TraceOption) DataConvertUtil.mapToObject((Map<String, Object>) call.arguments,
                        TraceOption.class);

        if (traceOption == null) {
            result.success(false);
            return;
        }

        mLBSTraceController.getLBSTraceClient().stopTrace(traceOption.toTrace(),
                new PluginOnTraceListener());

        result.success(true);
    }

    private void startGather(MethodChannel.Result result) {
        if (mLBSTraceController == null || mLBSTraceController.getLBSTraceClient() == null) {
            result.success(false);
            return;
        }

        mLBSTraceController.getLBSTraceClient().startGather(new PluginOnTraceListener());

        result.success(true);
    }

    private void stopGather(MethodChannel.Result result) {
        if (mLBSTraceController == null || mLBSTraceController.getLBSTraceClient() == null) {
            result.success(false);
            return;
        }

        mLBSTraceController.getLBSTraceClient().stopGather(new PluginOnTraceListener());

        result.success(true);
    }

    private void setInterval(MethodCall call, MethodChannel.Result result) {
        if (call == null || call.arguments == null || mLBSTraceController == null
                || mLBSTraceController.getLBSTraceClient() == null) {
            result.success(false);
            return;
        }

        int gatherInterval = Constant.GATHER_INTERVAL;
        int packInterval = Constant.PACKED_DATA_INTERVAL;

        Map<?, ?> map = DataConvertUtil.toMap(call.arguments);
        if (map.containsKey("gatherInterval")) {
            gatherInterval = DataConvertUtil.toInt(map.get("gatherInterval"));
        }

        if (map.containsKey("packInterval")) {
            packInterval = DataConvertUtil.toInt(map.get("packInterval"));
        }

        boolean ret = mLBSTraceController.getLBSTraceClient().setInterval(gatherInterval,
                packInterval);

        result.success(ret);
    }

    private void setCacheSize(MethodCall call, MethodChannel.Result result) {
        if (call == null || call.arguments == null || mLBSTraceController == null
                || mLBSTraceController.getLBSTraceClient() == null) {
            result.success(false);
            return;
        }

        int cacheSize = 0;

        Map<?, ?> map = DataConvertUtil.toMap(call.arguments);
        if (map.containsKey("size")) {
            cacheSize = DataConvertUtil.toInt(map.get("size"));
        }

        boolean ret = mLBSTraceController.getLBSTraceClient().setCacheSize(cacheSize);

        result.success(ret);
    }

    private class PluginOnTraceListener implements OnTraceListener {

        @Override
        public void onBindServiceCallback(int i, String s) {
            if (mLBSTraceController == null) {
                return;
            }

            BLog.e("onBindServiceCallback status = " + i + "; message = " + s);
            Map<String, Object> map = new HashMap<>();
            map.put("status", i);
            map.put("message", s);

            mLBSTraceController.getMethodChannel()
                    .invokeMethod(Constant.TraceMethodId.BIND_TRACE_SERVICE_CALLBACK, map);
        }

        @Override
        public void onStartTraceCallback(int i, String s) {
            if (mLBSTraceController == null) {
                return;
            }

            BLog.e("onStartTraceCallback status = " + i + "; message = " + s);
            Map<String, Object> map = new HashMap<>();
            map.put("status", i);
            map.put("message", s);

            mLBSTraceController.getMethodChannel()
                    .invokeMethod(Constant.TraceMethodId.START_TRACE_SERVICE_CALLBACK, map);
        }

        @Override
        public void onStopTraceCallback(int i, String s) {
            if (mLBSTraceController == null) {
                return;
            }

            BLog.e("onStopTraceCallback status = " + i + "; message = " + s);
            Map<String, Object> map = new HashMap<>();
            map.put("status", i);
            map.put("message", s);

            mLBSTraceController.getMethodChannel()
                    .invokeMethod(Constant.TraceMethodId.STOP_TRACE_SERVICE_CALLBACK, map);
        }

        @Override
        public void onStartGatherCallback(int i, String s) {
            if (mLBSTraceController == null) {
                return;
            }

            BLog.e("onStartGatherCallback status = " + i + "; message = " + s);
            Map<String, Object> map = new HashMap<>();
            map.put("status", i);
            map.put("message", s);

            mLBSTraceController.getMethodChannel()
                    .invokeMethod(Constant.TraceMethodId.START_GATHER_CALLBACK, map);
        }

        @Override
        public void onStopGatherCallback(int i, String s) {
            if (mLBSTraceController == null) {
                return;
            }

            BLog.e("onStopGatherCallback status = " + i + "; message = " + s);
            Map<String, Object> map = new HashMap<>();
            map.put("status", i);
            map.put("message", s);

            mLBSTraceController.getMethodChannel()
                    .invokeMethod(Constant.TraceMethodId.STOP_GATHER_CALLBACK, map);
        }

        @Override
        public void onPushCallback(byte b, PushMessage pushMessage) {

            BLog.e("onPushCallback b = " + b + "; pushMessage = " + pushMessage.toString());

            Map map = DataConvertUtil.objectToMap(new PushResult((int) b, pushMessage.getMessage(),
                    pushMessage.getFenceAlarmPushInfo()));

            mLBSTraceController.getMethodChannel()
                    .invokeMethod(Constant.TraceMethodId.ON_PUSH_CALLBACK, map);
        }

        @Override
        public void onInitBOSCallback(int i, String s) {

        }
    }

}
