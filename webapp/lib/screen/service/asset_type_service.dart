import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';

import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/asset_type.dart';

class AssetTypeService {
  NetworkManager networkManager;
  AssetTypeService({
    required this.networkManager,
  });

  Future<List<AssetType>?> getAssetTypes() async {
    ResponseModel<List<AssetType>> result =
        await networkManager.send<List<AssetType>, AssetType>(
            "/productType", HttpMethod.GET, AssetType(), null, null);
    return result.data;
  }

  Future<AssetType?> getAssetTypeDetail(int id) async {
    ResponseModel<AssetType?> result =
        await networkManager.send<AssetType, AssetType>(
            "/productType/popup/$id",
            HttpMethod.GET,
            AssetType(),
            null,
            null);
    return result.data;
  }

  Future<AssetType?> updateAssetType(AssetType assetType) async {
    ResponseModel<AssetType?> result =
        await networkManager.send<AssetType, AssetType>(
            "/productType",
            HttpMethod.PUT,
            AssetType(),
            json.encode(assetType.toJson()),
            null);
    return result.data;
  }

  Future<AssetType?> create(AssetType assetType) async {
    ResponseModel<AssetType?> result =
        await networkManager.send<AssetType, AssetType>(
            "/productType",
            HttpMethod.POST,
            AssetType(),
            json.encode(assetType.toJson()),
            null);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<AssetType?> result =
        await networkManager.send<AssetType, AssetType>(
            "/productType/$id",
            HttpMethod.DELETE,
            AssetType(),
            null,
            null);
    return result.error;
  }
}
