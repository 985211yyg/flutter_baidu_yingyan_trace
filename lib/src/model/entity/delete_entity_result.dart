import 'package:flutter_baidu_yingyan_trace/src/model/base_result.dart';

/// 删除Entity响应结果
class DeleteEntityResult extends BaseResult {
  DeleteEntityResult({int? tag, int? status, String? message})
      : super(tag: tag, status: status, message: message);

  /// map => DeleteEntityResult
  DeleteEntityResult.fromMap(Map map)
      : assert(map != null, // ignore: unnecessary_null_comparison
            'Construct a DeleteEntityResult，The parameter map cannot be null !'),
        super.fromMap(map);

  @override
  Map toMap() {
    return super.toMap();
  }

  @override
  String toString() {
    return "DeleteEntityResult{tag = $tag; status = $status; message = $message}";
  }
}
