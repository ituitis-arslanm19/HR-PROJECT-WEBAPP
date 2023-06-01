// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:webapp/core/base/base_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/request/create_time_off_request.dart';
import 'package:webapp/screen/model/time_off.dart';
import 'package:webapp/screen/model/time_off_sign.dart';
import 'package:webapp/screen/model/time_off_type.dart';
import 'package:mobx/mobx.dart';

import '../model/mobile_client.dart';

class TimeOffService {
  NetworkManager networkManager;
  TimeOffService({
    required this.networkManager,
  });

  Future<ResponseModel<Iterable<TimeOff>?>> getTimeOffs() async {
    ResponseModel<Iterable<TimeOff>> result =
        await networkManager.send<Iterable<TimeOff>, TimeOff>(
            "/timeOff/timeOffsByEmail", HttpMethod.GET, TimeOff(), null, TOKEN);
    return result;
  }

  Future<ResponseModel<TimeOff?>> requestNewTimeOff(
      CreateTimeOffRequest timeOff) async {
    ResponseModel<TimeOff> result = await networkManager.send<TimeOff, TimeOff>(
        "/timeOff/newTimeOff",
        HttpMethod.POST,
        TimeOff(),
        json.encode(timeOff.toJson()),
        TOKEN);
    return result;
  }

  Future<ResponseModel<Iterable<TimeOffType>?>> getTimeOffTypes() async {
    ResponseModel<Iterable<TimeOffType>> result =
        await networkManager.send<Iterable<TimeOffType>, TimeOffType>(
            "/timeOff/timeOffType", HttpMethod.GET, TimeOffType(), null, TOKEN);
    return result;
  }

  Future<List<TimeOffSign>?> getTimeOffsToSign() async {
    ResponseModel<List<TimeOffSign>> result =
        await networkManager.send<List<TimeOffSign>, TimeOffSign>(
            "/timeOff", HttpMethod.GET, TimeOffSign(), null, TOKEN);
    return result.data;
  }

  Future<TimeOffSign?> signTimeOff(int id) async {
    ResponseModel<TimeOffSign?> result = 
      await networkManager.send<TimeOffSign, TimeOffSign>("/timeOff/sign/$id", HttpMethod.PUT, TimeOffSign(), null, TOKEN);
    return result.data;
  }

  Future<Uint8List?> printTimeOff(int id) async {
    ResponseModel<Uint8List?> result = 
      await networkManager.send("/timeOff/document/$id", HttpMethod.GET, null, null, TOKEN);
    return base64Decode(result.description!);
  }
}
