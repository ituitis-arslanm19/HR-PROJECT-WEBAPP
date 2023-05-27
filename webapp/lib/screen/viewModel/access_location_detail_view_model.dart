// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/access_location_detail.dart';
import '../model/site.dart';
import '../service/access_location_service.dart';
import '../service/site_service.dart';

part 'access_location_detail_view_model.g.dart';

class AccessLocationDetailViewModel = _AccessLocationDetailViewModelBase
    with _$AccessLocationDetailViewModel;

abstract class _AccessLocationDetailViewModelBase with Store {
  final AccessLocationService accessLocationService;
  final SiteService siteService;
  final int? id;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<Site>? siteList;

  @observable
  AccessLocationDetail? accessLocationDetail;

  _AccessLocationDetailViewModelBase(
      this.accessLocationService, this.siteService, this.id, this.buildContext);

  @action
  init() async {
    siteList = await siteService.getSites();

    if (id == null) {
      accessLocationDetail = AccessLocationDetail();
    } else {
      accessLocationDetail =
          await accessLocationService.getAccessLocationDetail(id!);
    }
    textEditingControllerList
        .add(TextEditingController(text: accessLocationDetail!.name));
    textEditingControllerList.add(TextEditingController(
        text: accessLocationDetail!.type != null
            ? accessLocationDetail!.type.toString()
            : ""));
    textEditingControllerList
        .add(TextEditingController(text: accessLocationDetail!.location));
    if (accessLocationDetail != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  updateAccessLocation() async {
    accessLocationDetail!.name = textEditingControllerList[0].text;
    accessLocationDetail!.type = int.parse(textEditingControllerList[1].text);
    accessLocationDetail!.location = (textEditingControllerList[2].text);
    AccessLocationDetail? updatedAccessLocationDetail;
    dataState = DataState.LOADING;
    if (accessLocationDetail!.id != null) {
      updatedAccessLocationDetail = await accessLocationService
          .updateAccessLocation(accessLocationDetail!);
      if (updatedAccessLocationDetail != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Giriş Noktası başarıyla güncellendi")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content:
                Text("Giriş Noktası güncellenirken bir hata meydana geldi")));
      }
    } else {
      updatedAccessLocationDetail =
          await accessLocationService.create(accessLocationDetail!);
      if (updatedAccessLocationDetail != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(content: Text("Giriş Noktası başarıyla oluşturuldu")));
        return true;
      } else {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content:
                Text("Giriş Noktası oluştururken bir hata meydana geldi")));
      }
    }
    dataState = DataState.READY;
    return false;
  }
}
