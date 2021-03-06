import 'package:flutter_baidu_yingyan_trace/src/model/base_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/fence/fence_types.dart';

/// 增加围栏需监控的entity的请求响应结果
class AddMonitoredPersonOption extends BaseOption {
  /// 围栏的唯一标识
  late int fenceId;

  /// 需要添加的监控对象的名称数组，必选。
  /// 数组中每一项代表一个被监控对象的名称
  late List<String> monitoredPersons;

  /// 围栏类型。目前只支持服务端围栏.
  late FenceType fenceType;

  AddMonitoredPersonOption({
    required int tag,
    required int serviceId,
    required this.fenceId,
    required this.monitoredPersons,
    required this.fenceType,
  })  : assert(fenceId != null), // ignore: unnecessary_null_comparison
        assert(monitoredPersons != null), // ignore: unnecessary_null_comparison
        assert(fenceType != null), // ignore: unnecessary_null_comparison
        super(tag: tag, serviceId: serviceId);

  AddMonitoredPersonOption.fromMap(Map map)
      : assert(map != null), // ignore: unnecessary_null_comparison
        super.fromMap(map) {
    fenceId = map['fenceId'];
    if (map['monitoredPersons'] != null) {
      monitoredPersons = [];
      map['monitoredPersons'].forEach((e) {
        monitoredPersons.add(e as String);
      });
    }
    fenceType = FenceType.values[map['fenceType'] as int];
  }

  @override
  Map toMap() {
    Map map = super.toMap();
    map['fenceId'] = this.fenceId;
    map['monitoredPersons'] = this.monitoredPersons.map((e) => e).toList();
    map['fenceType'] = this.fenceType.index;
    return map;
  }
}
