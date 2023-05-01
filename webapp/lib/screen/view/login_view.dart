import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/screen/service/login_service.dart';
import 'package:webapp/screen/viewModel/login_view_model.dart';

import '../../core/widgets/other/shadow_container.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = LoginViewModel(
        LoginService(SecureStorage(),
            networkManager: NetworkManager(SecureStorage())),
        context);

    TextEditingController textController = TextEditingController();
    SizeConfig().init(context);

    loginViewModel.init();
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: SizedBox(
          height: SizeConfig.blockSizeVertical * 60,
          width: SizeConfig.blockSizeHorizontal * 60,
          child: ShadowContainer(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  buildTittle(theme, colorScheme),
                  buildTabBar(colorScheme, theme),
                  buildTabViews(textController, theme, loginViewModel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildTabViews(TextEditingController textController, ThemeData theme,
      LoginViewModel loginViewModel) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 30,
      width: SizeConfig.blockSizeHorizontal * 50,
      child: TabBarView(children: [
        buildLoginView(textController, theme, loginViewModel),
        buildRegisterView(textController, theme, loginViewModel)
      ]),
    );
  }

  Container buildTabBar(ColorScheme colorScheme, ThemeData theme) {
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 50,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TabBar(
            labelColor: colorScheme.primary,
            labelStyle: theme.textTheme.headlineMedium,
            indicatorColor: Colors.transparent,
            tabs: [
              const Tab(text: "Giriş Yap"),
              const Tab(text: "Kayıt Ol"),
            ]),
      ),
    );
  }

  Container buildTittle(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "HR Manager",
          style: theme.textTheme.headlineLarge!
              .copyWith(color: colorScheme.primary),
        ),
      ),
    );
  }

  Padding buildRegisterView(TextEditingController textController,
      ThemeData theme, LoginViewModel loginViewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Form(
        key: loginViewModel.formKeyRegister,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 50,
              child: Column(
                children: [
                  InputText(
                    textEditingController:
                        loginViewModel.controllers.elementAt(0),
                    icon: const Icon(Icons.email),
                    hintText: "Email",
                    validator: loginViewModel.inputTextValidator,
                  ),
                  InputText(
                    textEditingController:
                        loginViewModel.controllers.elementAt(1),
                    icon: const Icon(Icons.key),
                    hintText: "Şifre",
                    validator: loginViewModel.inputTextValidator,
                    obscure: true,
                  ),
                  InputText(
                    textEditingController: textController,
                    icon: const Icon(Icons.repeat),
                    hintText: "Şifre Tekrarı",
                    validator: loginViewModel.confirmPassValidator,
                    obscure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: SizeConfig.blockSizeVertical * 5,
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: Button(
                          onPressed: () {
                            loginViewModel.register();
                          },
                          text: "KAYIT OL"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildLoginView(TextEditingController textController, ThemeData theme,
      LoginViewModel loginViewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Form(
        key: loginViewModel.formKeyLogin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 50,
              child: Column(
                children: [
                  InputText(
                    textEditingController:
                        loginViewModel.controllers.elementAt(3),
                    icon: const Icon(Icons.email),
                    hintText: "Email",
                    validator: loginViewModel.inputTextValidator,
                  ),
                  InputText(
                    textEditingController:
                        loginViewModel.controllers.elementAt(4),
                    icon: const Icon(Icons.key),
                    hintText: "Şifre",
                    validator: loginViewModel.inputTextValidator,
                    obscure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: SizeConfig.blockSizeVertical * 5,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      child: Button(
                          onPressed: () => loginViewModel.login(),
                          text: "GİRİŞ YAP"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Şifremi Unuttum ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                loginViewModel.navigateToForgotPassword();
                              },
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: Colors.blue)),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
