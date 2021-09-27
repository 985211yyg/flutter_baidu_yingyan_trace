class GatherResult {
  /// 状态码
  int? status;

  /// 状态描述
  String? message;

  GatherResult.fromMap(Map map) : assert(map != null) { // ignore: unnecessary_null_comparison
    status = map['status'];
    message = map['message'];
  }

  Map toMap() {
    return {
      "status" : status,
      "message" : message,
    };
  }

}