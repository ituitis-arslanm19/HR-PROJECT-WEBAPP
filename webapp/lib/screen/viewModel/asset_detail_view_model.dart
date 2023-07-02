import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/asset_detail.dart';
import '../model/employee.dart';
import '../service/asset_service.dart';
import '../service/employee_service.dart';
part 'asset_detail_view_model.g.dart';

class AssetDetailViewModel = _AssetDetailViewModelBase
    with _$AssetDetailViewModel;

abstract class _AssetDetailViewModelBase with Store {
  final AssetService assetService;
  final EmployeeService employeeService;
  final int? id;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  AssetDetail? assetDetail;

  @observable
  List<Employee>? employeeList;

  List<String>? productType = ["PHONE", "LAPTOP", "HEADPHONE"];

  _AssetDetailViewModelBase(
      this.assetService, this.id, this.employeeService, this.buildContext);

  @action
  init() async {
    if (id == null) {
      assetDetail = AssetDetail();
    } else {
      assetDetail = await assetService.getAssetDetail(id!);
    }
    textEditingControllerList
        .add(TextEditingController(text: assetDetail!.name));
    textEditingControllerList
        .add(TextEditingController(text: assetDetail!.dateOfIssue));
    textEditingControllerList
        .add(TextEditingController(text: assetDetail!.description));
    employeeList = await employeeService.getEmployees();
    if (assetDetail != null) {
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
}
