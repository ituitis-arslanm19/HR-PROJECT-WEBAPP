import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import '../../core/constant/enum/enums.dart';
import '../model/asset_type.dart';
import '../service/asset_type_service.dart';
part 'asset_type_detail_view_model.g.dart';

class AssetTypeDetailViewModel = _AssetTypeDetailViewModelBase
    with _$AssetTypeDetailViewModel;

abstract class _AssetTypeDetailViewModelBase with Store {
  final AssetTypeService assetTypeService;
  final int? id;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  AssetType? assetType;

  _AssetTypeDetailViewModelBase(
      this.assetTypeService, this.id, this.buildContext);

  @action
  init() async {
    if (id == null) {
      assetType = AssetType();
    } else {
      assetType = await assetTypeService.getAssetTypeDetail(id!);
    }

    textEditingControllerList
        .add(TextEditingController(text: assetType!.name));
    if (assetType != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  Future<bool> updateAssetType() async {
    assetType!.name = textEditingControllerList[0].text;
    AssetType? updatedAssetType;
    dataState = DataState.LOADING;
    if (assetType!.id != null) {
      updatedAssetType =
          await assetTypeService.updateAssetType(assetType!);
      if (updatedAssetType != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Zimmet Tipi başarıyla güncellendi")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text("Zimmet Tipi güncellenirken bir hata meydana geldi")));
      }
    } else {
      updatedAssetType = await assetTypeService.create(assetType!);
      if (updatedAssetType != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Zimmet Tipi başarıyla oluşturuldu")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text("Zimmet Tipi oluştururken bir hata meydana geldi")));
      }
    }
    dataState = DataState.READY;
    return false;
  }
}
