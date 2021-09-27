import 'package:flutter_baidu_yingyan_trace/src/callback/entity_callback.dart';
import 'package:flutter_baidu_yingyan_trace/src/manager/base_manager.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/add_entity_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/around_search_entity_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/bound_search_entity_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/delete_entity_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/district_search_entity_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/keyword_search_entity_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/polygon_search_entity_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/real_time_loc_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/search_entity_list_option.dart';
import 'package:flutter_baidu_yingyan_trace/src/model/entity/update_entity_option.dart';

class EntityManager extends BaseManager {
  static final EntityManager _instance = EntityManager._internal();

  factory EntityManager() => _instance;

  EntityManager._internal();

  Future<bool> addEntity({
    required AddEntityOption addEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.addEntity(
        addEntityOption: addEntityOption, entityCallBack: entityCallBack);
  }

  Future<bool> aroundSearchEntity({
    required AroundSearchEntityOption aroundSearchEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.aroundSearchEntity(
        aroundSearchEntityOption: aroundSearchEntityOption,
        entityCallBack: entityCallBack);
  }

  Future<bool> boundSearchEntity({
    required BoundSearchEntityOption boundSearchEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.boundSearchEntity(
        boundSearchEntityOption: boundSearchEntityOption,
        entityCallBack: entityCallBack);
  }

  Future<bool> deleteEntity({
    required DeleteEntityOption deleteEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.deleteEntity(
        deleteEntityOption: deleteEntityOption, entityCallBack: entityCallBack);
  }

  Future<bool> districtSearchEntity({
    required DistrictSearchEntityOption districtSearchEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.districtSearchEntity(
        districtSearchEntityOption: districtSearchEntityOption,
        entityCallBack: entityCallBack);
  }

  Future<bool> keyWordSearchEntity({
    required KeyWordSearchEntityOption keyWordSearchEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.keyWordSearchEntity(
        keyWordSearchEntityOption: keyWordSearchEntityOption,
        entityCallBack: entityCallBack);
  }

  Future<bool> polygonSearchEntity({
    required PolygonSearchEntityOption polygonSearchEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.polygonSearchEntity(
        polygonSearchEntityOption: polygonSearchEntityOption,
        entityCallBack: entityCallBack);
  }

  Future<bool> queryEntityList({
    required EntityListSearchOption entityListSearchOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.queryEntityList(
        entityListSearchOption: entityListSearchOption,
        entityCallBack: entityCallBack);
  }

  Future<bool> updateEntity({
    required UpdateEntityOption updateEntityOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await baiduYingYanMethodChannel.updateEntity(
        updateEntityOption: updateEntityOption, entityCallBack: entityCallBack);
  }

  Future<bool> queryRealTimeLoc({
    required RealTimeLocationOption realTimeLocationOption,
    EntityCallBack? entityCallBack,
  }) async {
    return await this.baiduYingYanMethodChannel.queryRealTimeLoc(
        realTimeLocationOption: realTimeLocationOption,
        entityCallBack: entityCallBack);
  }

  Future<void> stopRealTimeLoc() async {
    return await baiduYingYanMethodChannel.stopRealTimeLoc();
  }
}
