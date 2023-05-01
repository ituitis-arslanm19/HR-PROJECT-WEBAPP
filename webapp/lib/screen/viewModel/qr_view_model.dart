// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/screen/service/qr_code_service.dart';
import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/qr_code.dart';
part 'qr_view_model.g.dart';

class QrViewModel = _QrViewModelBase with _$QrViewModel;

abstract class _QrViewModelBase extends BaseViewModel with Store {
  final QrCodeService qrCodeService;

  @observable
  DataState dataState = DataState.LOADING;
  @observable
  QrCode? result;
  @observable
  int countDown = 30;

  Timer? countdownTimer;

  _QrViewModelBase(this.qrCodeService);

  @override
  @action
  Future<void> init() async {
    result = await qrCodeService.getQrCode();

    if (result == null || result!.data == null) {
      dataState = DataState.ERROR;
    } else {
      countDown = result!.remainingTime!;
      countdownTimer =
          Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
      dataState = DataState.READY;
    }
  }

  @action
  void setCountDown() {
    countDown -= 1;
    if (countDown <= 0) {
      repeatProcess();
    }
  }

  @action
  void repeatProcess() {
    if (countdownTimer != null) countdownTimer!.cancel();

    dataState = DataState.LOADING;
    init();
  }
}
