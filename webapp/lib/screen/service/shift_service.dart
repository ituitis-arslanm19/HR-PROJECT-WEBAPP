// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/constant/strings.dart';

import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/shift.dart';

class ShiftService {
  NetworkManager networkManager;
  ShiftService({
    required this.networkManager,
  });

  Future<List<Shift>?> getShifts() async {
    ResponseModel<List<Shift>> result =
        await networkManager.send<List<Shift>, Shift>(
            "/shift", HttpMethod.GET, Shift(), null, TOKEN);
    return result.data;
  }

  Future<Shift?> getShiftById(int id) async {
    ResponseModel<Shift> result = await networkManager.send<Shift, Shift>(
        "/shift/popup/$id", HttpMethod.GET, Shift(), null, TOKEN);
    return result.data;
  }

  Future<Shift?> updateShift(Shift shift) async {
    ResponseModel<Shift?> result = await networkManager.send<Shift, Shift>(
        "/shift", HttpMethod.PUT, Shift(), json.encode(shift.toJson()), TOKEN);
    return result.data;
  }

  Future<Shift?> create(Shift shift) async {
    ResponseModel<Shift?> result = await networkManager.send<Shift, Shift>(
        "/shift", HttpMethod.POST, Shift(), json.encode(shift.toJson()), TOKEN);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<Shift?> result =
        await networkManager.send<Shift, Shift>(
            "/shift/$id",
            HttpMethod.DELETE,
            Shift(),
            null,
            TOKEN);
    return result.error;
  }
}
