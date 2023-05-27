import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/shift.dart';
import '../service/shift_service.dart';
part 'shift_detail_view_model.g.dart';

class ShiftDetailViewModel = _ShiftDetailViewModelBase with _$ShiftDetailViewModel;

abstract class _ShiftDetailViewModelBase with Store {
  final ShiftService shiftService;
  final int? id;
  final BuildContext buildContext;
  List<TextEditingController> textEditingControllerList = [];

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  Shift? shiftDetail;

  _ShiftDetailViewModelBase(this.shiftService, this.id, this.buildContext);

  @action
  init() async {
     if(id == null){
      shiftDetail = Shift();
    }
    else{
      shiftDetail = await shiftService.getShiftById(id!);
    }
    textEditingControllerList.add(TextEditingController(text: shiftDetail!.name));
    textEditingControllerList.add(TextEditingController(text: shiftDetail!.startTime));
    textEditingControllerList.add(TextEditingController(text: shiftDetail!.endTime));
    if (shiftDetail != null) {
        dataState = DataState.READY;
      } else {
        dataState = DataState.ERROR;
      }
  }

  @action
  updateShift() async{
    dataState = DataState.LOADING;
    shiftDetail!.name = textEditingControllerList[0].text;
    shiftDetail!.startTime = textEditingControllerList[1].text;
    shiftDetail!.endTime = textEditingControllerList[2].text;
    Shift? updatedShift;
    if(shiftDetail!.id != null){
      updatedShift = await shiftService.updateShift(shiftDetail!);
      if(updatedShift != null){
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Vardiya başarıyla güncellendi")));
      return true;
    }
    else{
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Vardiya güncellenirken bir hata meydana geldi")));
        
    }
    }
    else{
      updatedShift = await shiftService.create(shiftDetail!);
      if(updatedShift != null){
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Vardiya başarıyla oluşturuldu")));
      return true;
    }
    else{
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("Vardiya oluştururken bir hata meydana geldi")));
    }
    }
  dataState = DataState.READY;
  return false;
  }
}