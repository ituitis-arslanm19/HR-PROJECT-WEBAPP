import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/base/base_view.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/theme/app_theme.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/screen/service/qr_code_service.dart';
import 'package:webapp/screen/viewModel/qr_view_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/network/network_manager.dart';

class QrView extends StatelessWidget {
  QrView({super.key});

  QrViewModel qrViewModel =
      QrViewModel(QrCodeService(NetworkManager(SecureStorage())));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    qrViewModel.init();

    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [buildQrCode(), buildInfoText(), buildButton(context)],
      ),
    );
  }

  Container buildQrCode() {
    return Container(
      height: SizeConfig.blockSizeVertical * 50,
      child: Observer(builder: (context) {
        switch (qrViewModel.dataState) {
          case DataState.LOADING:
            return const Center(child: CircularProgressIndicator());

          case DataState.READY:
            return Column(
              children: [
                Text(qrViewModel.countDown.toString() + " sn",
                    style: AppTheme.lightTheme.textTheme.headlineLarge),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                  child: QrImage(data: qrViewModel.result!.data!),
                ),
              ],
            );

          case DataState.ERROR:
            return Center(
              child: Text(
                "Beklenmeyen bir hata meydana geldi.",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            );

          default:
            return const CircularProgressIndicator();
        }
      }),
    );
  }

  Text buildInfoText() {
    return Text(
      "Lütfen QR kodu tarayıcıya gösteriniz",
      style: AppTheme.lightTheme.textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Container buildButton(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      height: SizeConfig.screenWidth * 0.11,
      child: Button(
        onPressed: qrViewModel.repeatProcess,
        text: "YENI QR KOD AL",
      ),
    );
  }
}
