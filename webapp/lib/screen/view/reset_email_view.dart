import 'package:flutter/material.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/shadow_container.dart';
import '../../core/util/size_config.dart';
import '../service/reset_email_service.dart';
import '../viewModel/reset_email_view_model.dart';

class ResetEmailView extends StatelessWidget {
  const ResetEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    ResetEmailViewModel resetEmailViewModel = ResetEmailViewModel(
        buildContext: context,
        ResetEmailService(networkManager: NetworkManager()));
    resetEmailViewModel.init();
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
              key: resetEmailViewModel.formKeyReset,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lütfen sisteme kayıtlı e-posta adresinizi giriniz",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: colorScheme.primary),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  InputText(
                    textEditingController:
                        resetEmailViewModel.textEditingController,
                    icon: const Icon(Icons.email),
                    hintText: "Email",
                    validator: resetEmailViewModel.inputTextValidator,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                        child: Button(
                            onPressed: () {
                              resetEmailViewModel.sendCode();
                            },
                            text: "KOD GÖNDER")),
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
