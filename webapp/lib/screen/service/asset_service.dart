// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/request/update_asset_status_request.dart';

import '../../core/network/model/response_model.dart';
import '../../core/network/network_manager.dart';
import '../model/asset.dart';
import '../model/asset_detail.dart';

class AssetService {
  NetworkManager networkManager;
  AssetService({
    required this.networkManager,
  });

  Future<List<Asset>?> getAssets() async {
    ResponseModel<List<Asset>> result =
        await networkManager.send<List<Asset>, Asset>(
            "/product", HttpMethod.GET, Asset(), null, null);
    return result.data;
  }

  Future<AssetDetail?> getAssetDetail(int id) async {
    ResponseModel<AssetDetail?> result =
        await networkManager.send<AssetDetail, AssetDetail>(
            "/product/popup/$id", HttpMethod.GET, AssetDetail(), null, null);
    return result.data;
  }

  Future<AssetDetail?> updateAsset(AssetDetail assetDetail) async {
    ResponseModel<AssetDetail?> result =
        await networkManager.send<AssetDetail, AssetDetail>(
            "/product",
            HttpMethod.PUT,
            AssetDetail(),
            json.encode(assetDetail.toJson()),
            null);
    return result.data;
  }

  Future<AssetDetail?> create(AssetDetail assetDetail) async {
    ResponseModel<AssetDetail?> result =
        await networkManager.send<AssetDetail, AssetDetail>(
            "/product",
            HttpMethod.POST,
            AssetDetail(),
            json.encode(assetDetail.toJson()),
            null);
    return result.data;
  }

  Future<AssetDetail?> updateAssetStatus(
      UpdateAssetStatusRequest updateAssetStatusRequest) async {
    ResponseModel<AssetDetail?> result =
        await networkManager.send<AssetDetail, AssetDetail>(
            "/product/status",
            HttpMethod.PUT,
            AssetDetail(),
            json.encode(updateAssetStatusRequest.toJson()),
            null);
    return result.data;
  }

  Future<bool?> delete(int id) async {
    ResponseModel<AssetDetail?> result =
        await networkManager.send<AssetDetail, AssetDetail>(
            "/product/$id", HttpMethod.DELETE, AssetDetail(), null, null);
    return result.error;
  }
}
