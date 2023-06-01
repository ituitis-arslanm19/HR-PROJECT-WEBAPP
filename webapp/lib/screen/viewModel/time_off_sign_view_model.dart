import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/time_off_sign.dart';
import '../service/time_off_service.dart';
import 'dart:html' as html;
part 'time_off_sign_view_model.g.dart';

class TimeOffSignViewModel = _TimeOffSignViewModelBase with _$TimeOffSignViewModel;

abstract class _TimeOffSignViewModelBase with Store {
  final TimeOffService timeOffService;
  final BuildContext buildContext;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<TimeOffSign>? timeOffList;

  @observable
  List<TimeOffSign>? timeOffs;

  _TimeOffSignViewModelBase(this.timeOffService, this.buildContext);

  @action
  init() async {
    timeOffs = await timeOffService.getTimeOffsToSign();
    timeOffList = timeOffs;
    if (timeOffList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name){
    timeOffList = timeOffs?.where((timeOff) => timeOff.firstName!.toLowerCase().startsWith(name.toLowerCase())).toList();
  }

  @action
  Future<bool> signTimeOffSign(int id) async {
    dataState = DataState.LOADING;
    TimeOffSign? signedTimeOffSign;
    signedTimeOffSign = await timeOffService.signTimeOff(id);
    if(signedTimeOffSign != null){
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("İzin başarıyla imzalandı")));
      init();
      return true;
    }
      dataState = DataState.READY;
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(SnackBar(content: Text("İzin imzalanırken bir hata meydana geldi")));
      return false;
  }

  @action
  Future<Uint8List?> printTimeOff(int id) async {
    Uint8List? list = await timeOffService.printTimeOff(id);
    final blob = html.Blob([list], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'izin_belgesi.pdf';
    html.document.body!.children.add(anchor);
    anchor.click();
    return list;
  }
 }