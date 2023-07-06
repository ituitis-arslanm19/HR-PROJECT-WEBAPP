import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';

import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/time_off_type.dart';

class TimeOffTypeService {
  NetworkManager networkManager;
  TimeOffTypeService({
    required this.networkManager,
  });

  Future<List<TimeOffType>?> getTimeOffTypes() async {
    ResponseModel<List<TimeOffType>> result =
        await networkManager.send<List<TimeOffType>, TimeOffType>(
            "/timeOffType", HttpMethod.GET, TimeOffType(), null, null);
    return result.data;
  }

  Future<TimeOffType?> getTimeOffTypeDetail(int id) async {
    ResponseModel<TimeOffType?> result =
        await networkManager.send<TimeOffType, TimeOffType>(
            "/timeOffType/popup/$id",
            HttpMethod.GET,
            TimeOffType(),
            null,
            null);
    return result.data;
  }

  Future<TimeOffType?> updateTimeOffType(TimeOffType timeOffType) async {
    ResponseModel<TimeOffType?> result =
        await networkManager.send<TimeOffType, TimeOffType>(
            "/timeOffType",
            HttpMethod.PUT,
            TimeOffType(),
            json.encode(timeOffType.toJson()),
            null);
    return result.data;
  }

  Future<TimeOffType?> create(TimeOffType timeOffType) async {
    ResponseModel<TimeOffType?> result =
        await networkManager.send<TimeOffType, TimeOffType>(
            "/timeOffType",
            HttpMethod.POST,
            TimeOffType(),
            json.encode(timeOffType.toJson()),
            null);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<TimeOffType?> result =
        await networkManager.send<TimeOffType, TimeOffType>(
            "/productType/$id",
            HttpMethod.DELETE,
            TimeOffType(),
            null,
            null);
    return result.error;
  }
}
