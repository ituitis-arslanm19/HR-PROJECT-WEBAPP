// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/constant/strings.dart';

import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/access_location.dart';
import '../model/access_location_detail.dart';

class AccessLocationService {
  NetworkManager networkManager;
  AccessLocationService({
    required this.networkManager,
  });

  Future<List<AccessLocation>?> getAccessLocations() async {
    ResponseModel<List<AccessLocation>> result =
        await networkManager.send<List<AccessLocation>, AccessLocation>(
            "/accessLocation", HttpMethod.GET, AccessLocation(), null, TOKEN);
    return result.data;
  }

  Future<AccessLocationDetail?> getAccessLocationDetail(int id) async {
    ResponseModel<AccessLocationDetail?> result =
        await networkManager.send<AccessLocationDetail, AccessLocationDetail>(
            "/accessLocation/popup/$id",
            HttpMethod.GET,
            AccessLocationDetail(),
            null,
            null);
    return result.data;
  }

  Future<AccessLocationDetail?> updateAccessLocation(
      AccessLocationDetail accessLocationDetail) async {
    ResponseModel<AccessLocationDetail?> result =
        await networkManager.send<AccessLocationDetail, AccessLocationDetail>(
            "/accessLocation",
            HttpMethod.PUT,
            AccessLocationDetail(),
            json.encode(accessLocationDetail.toJson()),
            null);
    return result.data;
  }

  Future<AccessLocationDetail?> create(
      AccessLocationDetail accessLocationDetail) async {
    ResponseModel<AccessLocationDetail?> result =
        await networkManager.send<AccessLocationDetail, AccessLocationDetail>(
            "/accessLocation",
            HttpMethod.POST,
            AccessLocationDetail(),
            json.encode(accessLocationDetail.toJson()),
            TOKEN);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<AccessLocationDetail?> result =
        await networkManager.send<AccessLocationDetail, AccessLocationDetail>(
            "/accessLocation/$id",
            HttpMethod.DELETE,
            AccessLocationDetail(),
            null,
            TOKEN);
    return result.error;
  }
}
