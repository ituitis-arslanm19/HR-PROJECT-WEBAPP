import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/theme/app_theme.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/shadow_container.dart';
import 'package:webapp/screen/view/home_view.dart';
import 'package:webapp/screen/view/product_view.dart';
import 'package:webapp/screen/view/profile_view.dart';
import 'package:webapp/screen/view/qr_view.dart';
import 'package:webapp/screen/view/time_off_view.dart';
import 'package:webapp/screen/view/time_off_approval_view.dart';
import 'package:webapp/screen/viewModel/main_view_model.dart';

class MainView extends StatelessWidget {
  final ClientType clientType;
  MainView({super.key, required this.clientType});
  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = MainViewModel(context, SecureStorage());

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    SizeConfig().init(context);

    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   centerTitle: false,
            //   titleSpacing: 20.0,
            //   automaticallyImplyLeading: false,
            //   elevation: 0,
            //   title: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "HR Manager",
            //       style: GoogleFonts.aBeeZee(
            //           color: colorScheme.onPrimary,
            //           fontWeight: FontWeight.bold),
            //       textAlign: TextAlign.start,
            //     ),
            //   ),
            //   backgroundColor: colorScheme.primary,
            // ),
            body: Row(
      children: [
        Expanded(
            flex: 3,
            child:
                buildNavigationBar(mainViewModel, theme, colorScheme, context)),
        Expanded(
          flex: 18,
          child: Container(
            color: Colors.grey[50],
            child: Observer(builder: (context) {
              switch (mainViewModel.bnbIndex) {
                case 0:
                  return HomeView();

                case 1:
                  return TimeOffView();

                case 2:
                  return TimeOffApprovalView();

                default:
                  return HomeView();
              }
            }),
          ),
        ),
      ],
    )));
  }

  Drawer buildNavigationBar(MainViewModel mainViewModel, ThemeData theme,
      ColorScheme colorScheme, BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      backgroundColor: colorScheme.primary,
      child: ListView(children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical * 8,
          child: DrawerHeader(
            child: Text(
              "HR Manager",
              style: GoogleFonts.aBeeZee(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            _onItemTapped(0, mainViewModel);
          },
          textColor: Colors.red,
          leading: Observer(builder: (_) {
            return Icon(Icons.home,
                color: mainViewModel.bnbIndex == 0
                    ? colorScheme.background
                    : Colors.grey);
          }),
          title: Observer(builder: (_) {
            return Text(
              'Ana Ekran',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: mainViewModel.bnbIndex == 0
                      ? colorScheme.background
                      : Colors.grey,
                  fontWeight: FontWeight.bold),
            );
          }),
        ),
        ListTile(onTap: () {
          _onItemTapped(1, mainViewModel);
        }, leading: Observer(builder: (_) {
          return Icon(
            Icons.person,
            color: mainViewModel.bnbIndex == 1
                ? colorScheme.background
                : Colors.grey,
          );
        }), title: Observer(builder: (_) {
          return Observer(builder: (_) {
            return Text(
              'İzin',
              style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mainViewModel.bnbIndex == 1
                      ? colorScheme.background
                      : Colors.grey),
            );
          });
        })),
        ListTile(
          onTap: () {
            _onItemTapped(2, mainViewModel);
          },
          leading: Observer(builder: (_) {
            return Icon(Icons.check,
                color: mainViewModel.bnbIndex == 2
                    ? colorScheme.background
                    : Colors.grey);
          }),
          title: Observer(builder: (_) {
            return Text(
              'Onay',
              style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mainViewModel.bnbIndex == 2
                      ? colorScheme.background
                      : Colors.grey),
            );
          }),
        ),
        ListTile(
          onTap: () {
            _onItemTapped(3, mainViewModel);
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: Container(
                  height: SizeConfig.blockSizeVertical * 15,
                  width: SizeConfig.blockSizeHorizontal * 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Çıkış yapmak istediğinize emin misiniz?",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => mainViewModel.logout(),
                            child: Text(
                              "ÇIKIŞ YAP",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "İPTAL",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ) //Your buttons here
                ,
              ),
            );
          },
          leading: Observer(builder: (_) {
            return Icon(
              Icons.logout,
              color: mainViewModel.bnbIndex == 3
                  ? colorScheme.background
                  : Colors.grey,
            );
          }),
          title: Observer(builder: (_) {
            return Text(
              'Çıkış Yap',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: mainViewModel.bnbIndex == 3
                      ? colorScheme.background
                      : Colors.grey),
            );
          }),
        ),
      ]

          // selectedIndex: mainViewModel.bnbIndex,
          // onDestinationSelected: (index) => _onItemTapped(index, mainViewModel),
          ),
    );
  }

  void _onItemTapped(int index, MainViewModel mainViewModel) {
    if (index != mainViewModel.bnbIndex) mainViewModel.setBnbIndex(index);
  }
}
