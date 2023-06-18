import 'package:flutter/material.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/shadow_container.dart';
import 'package:webapp/screen/service/reset_password_service.dart';
import 'package:webapp/screen/viewModel/reset_password_view_model.dart';

import '../../core/util/size_config.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    ResetPasswordViewModel resetPasswordViewModel = ResetPasswordViewModel(
        context,
        ResetPasswordService(networkManager: NetworkManager()),
        SecureStorage());
    resetPasswordViewModel.init();
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
          width: SizeConfig.blockSizeVertical * 60,
          child: ShadowContainer(
            child: Form(
              key: resetPasswordViewModel.formKeyReset,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lütfen yeni şifrenizi belirleyin",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: colorScheme.primary),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  InputText(
                    textEditingController:
                        resetPasswordViewModel.controllers.elementAt(0),
                    icon: const Icon(Icons.key),
                    hintText: "Şifre",
                    validator: resetPasswordViewModel.inputTextValidator,
                    obscure: true,
                  ),
                  InputText(
                    textEditingController:
                        resetPasswordViewModel.controllers.elementAt(1),
                    icon: const Icon(Icons.repeat),
                    hintText: "Şifre Tekrarı",
                    validator: resetPasswordViewModel.confirmPassValidator,
                    obscure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                        child: Button(
                            onPressed: () {
                              resetPasswordViewModel.updatePassword();
                            },
                            text: "KAYDET")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
