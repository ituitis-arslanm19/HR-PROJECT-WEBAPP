import 'package:flutter/material.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/shadow_container.dart';
import '../../core/base/base_view.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/scrollable_page.dart';
import '../service/reset_email_service.dart';
import '../viewModel/reset_email_view_model.dart';

class ResetEmailView extends StatelessWidget {
  const ResetEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetEmailViewModel>(
      viewModel: ResetEmailViewModel(
          ResetEmailService(networkManager: NetworkManager()),
          buildContext: context),
      onModelReady: (model) {
        model.init();
      },
      onPageBuilder: (context, viewModel, theme) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          leading: BackButton(
            color: theme.colorScheme.primary,
          ),
        ),
        body: ScrollablePage(
          child: SizedBox(
            height: SizeConfig.blockSizeVertical * 60,
            width: SizeConfig.blockSizeVertical * 60,
            child: ShadowContainer(
              child: Form(
                key: viewModel.formKeyReset,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Lütfen sisteme kayıtlı e-posta adresinizi giriniz",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.colorScheme.primary),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    InputText(
                      textEditingController: viewModel.textEditingController,
                      icon: const Icon(Icons.email),
                      hintText: "Email",
                      validator: viewModel.inputTextValidator,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                          child: Button(
                              onPressed: () {
                                viewModel.sendCode();
                              },
                              text: "KOD GÖNDER")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
