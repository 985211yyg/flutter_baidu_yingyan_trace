import 'dart:io';

/// 填写你在API控制台申请的iOS类型的AK
/// https://passport.baidu.com/v2/
final ak = "1BBs5Zmo9UPbmqwCFWEV5oW5uixsQ9q6";

/// 填写你在API控制台申请iOS类型AK时指定的Bundle Identifier
final mcode = "com.baidu.mapsdk.ios.demo";

/// 填写你在鹰眼轨迹管理台创建的鹰眼服务对应的ID
final serviceID = Platform.isAndroid ? 225544 : 216029;

/// 用户自定义的entity标识，同一serviceId下该字段不允许重复
String entityName_test = Platform.isAndroid ? "sptest" : "Modi";
