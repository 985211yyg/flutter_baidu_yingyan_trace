import 'package:flutter_baidu_yingyan_trace/src/interface/location_interface.dart';
import 'package:flutter_baidu_yingyan_trace/src/manager/base_manager.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/location/location_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/location_mode.dart';

class LocationManager extends BaseManager implements LocationInterface {
  @override
  Future<bool> requestLocalPermission() async {
    return await this.baiduYingYanMethodChannel.requestLocalPermission();
  }

  @override
  Future<bool> configLocationInfo({required LocationOption locationOption}) async {
    return await this.baiduYingYanMethodChannel.configLocationInfo(locationOption: locationOption);
  }

  Future<bool> setLocationMode(LocationMode locationMode) async {
    return await this.baiduYingYanMethodChannel.setLocationMode(locationMode);
  }
}
