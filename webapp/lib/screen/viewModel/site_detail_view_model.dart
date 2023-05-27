import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/site.dart';
import '../service/site_service.dart';
part 'site_detail_view_model.g.dart';

class SiteDetailViewModel = _SiteDetailViewModelBase with _$SiteDetailViewModel;

abstract class _SiteDetailViewModelBase with Store {
  final SiteService siteService;
  final int? id;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  Site? siteDetail;

  _SiteDetailViewModelBase(this.siteService, this.id, this.buildContext);

  @action
  init() async {
     if(id == null){
      siteDetail = Site();
    }
    else{
      siteDetail = await siteService.getSiteById(id!);
    }
    textEditingControllerList.add(TextEditingController(text: siteDetail!.name));
    if (siteDetail != null) {
        dataState = DataState.READY;
      } else {
        dataState = DataState.ERROR;
      }
  }

  @action
  updateSite() async{
    dataState = DataState.LOADING;
    siteDetail!.name = textEditingControllerList[0].text;
    Site? updatedSite;
    if(siteDetail!.id != null){
      updatedSite = await siteService.updateSite(siteDetail!);
      if(updatedSite != null){
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Alan başarıyla güncellendi")));
      return true;
    }
    else{
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Alan güncellenirken bir hata meydana geldi")));
        
    }
    }
    else{
      updatedSite = await siteService.create(siteDetail!);
      if(updatedSite != null){
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Alan başarıyla oluşturuldu")));
      return true;
    }
    else{
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Alan oluştururken bir hata meydana geldi")));
    }
    }
  dataState = DataState.READY;
  return false;
  }
}