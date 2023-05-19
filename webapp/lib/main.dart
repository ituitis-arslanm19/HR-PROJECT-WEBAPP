import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_card.dart';
import 'package:webapp/screen/view/home_view.dart';
import 'package:webapp/screen/view/login_view.dart';
import 'package:webapp/screen/view/main_view.dart';
import 'package:webapp/screen/view/profile_view.dart';
import 'package:webapp/screen/view/splash_view.dart';

import 'core/theme/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var list = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('tr'),
        ],
        theme: AppTheme.lightTheme,
        // ignore: prefer_const_constructors
        home: Scaffold(
            body: MainView(
          clientType: ClientType.ADMIN,
        )));
  }
}
