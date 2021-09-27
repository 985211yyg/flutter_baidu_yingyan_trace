/// 代表经纬度
class LatLng {
  /// 纬度
  late double latitude;

  /// 经度
  late double longitude;

  /// 有参构造
  LatLng(this.latitude, this.longitude)
      : assert(latitude != null), // ignore: unnecessary_null_comparison
        assert(longitude != null); // ignore: unnecessary_null_comparison

  /// map => LatLng
  LatLng.fromMap(Map map) : assert(map != null) { // ignore: unnecessary_null_comparison
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  /// LatLng => map
  Map toMap() {
    return {"latitude": latitude, "longitude": longitude};
  }
}
