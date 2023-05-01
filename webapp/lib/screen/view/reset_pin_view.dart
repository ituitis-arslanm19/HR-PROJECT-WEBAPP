import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/pin_field.dart';
import 'package:webapp/screen/service/reset_pin_service.dart';
import 'package:webapp/screen/viewModel/reset_password_view_model.dart';
import 'package:webapp/screen/viewModel/reset_pin_view_model.dart';

import '../../core/util/size_config.dart';
import '../../core/widgets/other/shadow_container.dart';

class ResetPinView extends StatelessWidget {
  final String email;
  const ResetPinView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    ResetPinViewModel resetPinViewModel = ResetPinViewModel(
        context,
        ResetPinService(networkManager: NetworkManager(SecureStorage())),
        SecureStorage());
    resetPinViewModel.init();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: BackButton(
          color: colorScheme.primary,
        ),
      ),
      body: Center(
        child: SizedBox(
          height: SizeConfig.blockSizeVertical * 60,
          width: SizeConfig.blockSizeHorizontal * 60,
          child: ShadowContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Observer(builder: (_) {
                  return Text(
                    "${resetPinViewModel.countDown} sn",
                    style: theme.textTheme.headlineLarge,
                  );
                }),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Text(
                  "Lütfen e-postanıza gelen doğrulama kodunu giriniz",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: colorScheme.primary),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                PinField(
                  controllers: resetPinViewModel.controllers,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                      height: SizeConfig.blockSizeVertical * 5,
                      width: SizeConfig.blockSizeHorizontal * 75,
                      child: Button(
                          onPressed: () {
                            resetPinViewModel.checkCode(email);
                          },
                          text: "DOĞRULA")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
