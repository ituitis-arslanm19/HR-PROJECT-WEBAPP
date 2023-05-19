// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/approved_time_off.dart';
import 'package:webapp/screen/model/request/create_time_off_request.dart';
import 'package:webapp/screen/model/request/update_time_off_request.dart';
import 'package:webapp/screen/model/time_off.dart';
import 'package:mobx/mobx.dart';

import '../model/mobile_client.dart';

class TimeOffApprovalService {
  NetworkManager networkManager;
  TimeOffApprovalService({
    required this.networkManager,
  });

  Future<ResponseModel<Iterable<ApprovedTimeOff>?>>
      getApprovedTimeOffs() async {
    ResponseModel<Iterable<ApprovedTimeOff>> result =
        await networkManager.send<Iterable<ApprovedTimeOff>, ApprovedTimeOff>(
            "/timeOff/approvedTimeOffs",
            HttpMethod.GET,
            ApprovedTimeOff(),
            null,
            null);
    return result;
  }

  Future<ResponseModel<Iterable<ApprovedTimeOff>?>> getPendingTimeOffs() async {
    ResponseModel<Iterable<ApprovedTimeOff>> result =
        await networkManager.send<Iterable<ApprovedTimeOff>, ApprovedTimeOff>(
            "/timeOff/timeOffsByManagerEmail",
            HttpMethod.GET,
            ApprovedTimeOff(),
            null,
            null);
    return result;
  }

  Future<ResponseModel<ApprovedTimeOff?>> updateTimeOff(
      UpdateTimeOffRequest updateTimeOffRequest) async {
    ResponseModel<ApprovedTimeOff?> result =
        await networkManager.send<ApprovedTimeOff, ApprovedTimeOff>(
            "/timeOff/update",
            HttpMethod.PUT,
            ApprovedTimeOff(),
            json.encode(updateTimeOffRequest.toJson()),
            null);
    return result;
  }
}
