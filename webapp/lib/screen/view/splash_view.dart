import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/service/splash_service.dart';
import 'package:webapp/screen/viewModel/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    SplashViewModel splashViewModel = SplashViewModel(
        context,
        SplashService(SecureStorage(),
            networkManager: NetworkManager(SecureStorage())));
    splashViewModel.init();
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
    ;
  }
}
