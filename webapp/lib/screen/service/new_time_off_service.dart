// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/request/create_time_off_request.dart';
import 'package:webapp/screen/model/time_off.dart';
import 'package:webapp/screen/model/time_off_type.dart';
import 'package:mobx/mobx.dart';

import '../model/mobile_client.dart';

class NewTimeOffService {
  NetworkManager networkManager;
  NewTimeOffService({
    required this.networkManager,
  });

  Future<ResponseModel<TimeOff?>> requestNewTimeOff(
      CreateTimeOffRequest timeOff) async {
    ResponseModel<TimeOff> result = await networkManager.send<TimeOff, TimeOff>(
        "/timeOff/newTimeOff",
        HttpMethod.POST,
        TimeOff(),
        json.encode(timeOff.toJson()),
        null);
    return result;
  }

  Future<ResponseModel<Iterable<TimeOffType>?>> getTimeOffTypes() async {
    ResponseModel<Iterable<TimeOffType>> result =
        await networkManager.send<Iterable<TimeOffType>, TimeOffType>(
            "/timeOff/timeOffType", HttpMethod.GET, TimeOffType(), null, TOKEN);

    return result;
  }
}
