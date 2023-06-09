import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:webapp/screen/model/request/update_asset_status_request.dart';
import 'package:webapp/screen/service/asset_type_service.dart';

import '../../core/constant/enum/enums.dart';
import '../model/asset_detail.dart';
import '../model/asset_type.dart';
import '../model/employee.dart';
import '../service/asset_service.dart';
import '../service/employee_service.dart';
part 'asset_detail_view_model.g.dart';

class AssetDetailViewModel = _AssetDetailViewModelBase
    with _$AssetDetailViewModel;

abstract class _AssetDetailViewModelBase with Store {
  final AssetService assetService;
  final AssetTypeService assetTypeService;
  final EmployeeService employeeService;
  final int? id;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];
  @observable
  List<AssetType>? assetTypeList;

  @observable
  DataState dataState = DataState.LOADING;

  ProductStatus? productStatus;

  @observable
  bool pageState = false;

  @observable
  AssetDetail? assetDetail;

  @observable
  List<Employee>? employeeList;

  _AssetDetailViewModelBase(this.assetService, this.id, this.assetTypeService,
      this.employeeService, this.buildContext);

  @action
  init() async {
    if (id == null) {
      assetDetail = AssetDetail();
    } else {
      assetDetail = await assetService.getAssetDetail(id!);
    }
    if (assetDetail != null) {
      textEditingControllerList
          .add(TextEditingController(text: assetDetail!.name));
      textEditingControllerList
          .add(TextEditingController(text: assetDetail!.dateOfIssue));
      textEditingControllerList
          .add(TextEditingController(text: assetDetail!.description));
      employeeList = await employeeService.getEmployees();
      assetTypeList = await assetTypeService.getAssetTypes();

      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  updateAsset() async {
    dataState = DataState.LOADING;
    assetDetail!.name = textEditingControllerList[0].text;
    assetDetail!.dateOfIssue = textEditingControllerList[1].text;
    assetDetail!.description = textEditingControllerList[2].text;
    AssetDetail? updatedAsset;
    if (assetDetail!.id != null) {
      updatedAsset = await assetService.updateAsset(assetDetail!);
      if (updatedAsset != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Zimmetli ürün başarıyla güncellendi")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content:
                Text("Zimmetli ürün güncellenirken bir hata meydana geldi")));
      }
    } else {
      updatedAsset = await assetService.create(assetDetail!);
      if (updatedAsset != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Zimmetli ürün başarıyla oluşturuldu")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content:
                Text("Zimmetli ürün oluştururken bir hata meydana geldi")));
      }
    }
    dataState = DataState.READY;
    return false;
  }

  @action
  Future<bool> updateAssetStatus() async {
    AssetDetail? response = await assetService.updateAssetStatus(
        UpdateAssetStatusRequest(id: assetDetail!.id, status: productStatus));

    return response == null ? false : true;
  }
}
