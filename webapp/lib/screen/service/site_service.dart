// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';

import '../../core/constant/strings.dart';
import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/site.dart';

class SiteService {
  NetworkManager networkManager;
  SiteService({
    required this.networkManager,
  });

  Future<List<Site>?> getSites() async {
    ResponseModel<List<Site>> result = await networkManager
        .send<List<Site>, Site>("/site", HttpMethod.GET, Site(), null, null);
    return result.data;
  }

  Future<Site?> getSiteById(int id) async {
    ResponseModel<Site> result = await networkManager.send<Site, Site>(
        "/site/popup/$id", HttpMethod.GET, Site(), null, null);
    return result.data;
  }

  Future<Site?> updateSite(Site site) async {
    ResponseModel<Site?> result = await networkManager.send<Site, Site>(
        "/site", HttpMethod.PUT, Site(), json.encode(site.toJson()), null);
    return result.data;
  }

  Future<Site?> create(Site site) async {
    ResponseModel<Site?> result = await networkManager.send<Site, Site>(
        "/site", HttpMethod.POST, Site(), json.encode(site.toJson()), null);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<Site?> result =
        await networkManager.send<Site, Site>(
            "/site/$id",
            HttpMethod.DELETE,
            Site(),
            null,
            TOKEN);
    return result.error;
  }
}
