import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/theme/app_theme.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/nav_item.dart';
import 'package:webapp/core/widgets/other/shadow_container.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/screen/view/admin_view.dart';
import 'package:webapp/screen/view/department_view.dart';
import 'package:webapp/screen/view/department_list_view.dart';
import 'package:webapp/screen/view/employee_view.dart';
import 'package:webapp/screen/view/employee_list_view.dart';
import 'package:webapp/screen/view/home_view.dart';
import 'package:webapp/screen/view/product_view.dart';
import 'package:webapp/screen/view/profile_view.dart';
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

    return Scaffold(
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
          flex: 16,
          child: Container(
            color: Colors.grey[50],
            child: Observer(builder: (context) {
              switch (mainViewModel.bnbIndex) {
                case 0:
                  return HomeView();

                case 1:
                  //return TimeOffView();
                  return TimeOffView();

                case 3:
                  //return TimeOffApprovalView();
                  return EmployeeListView(
                    clientType: clientType,
                  );

                case 4:
                  //return TimeOffApprovalView();
                  return DepartmentListView();

                case 5:
                  return AdminView();

                default:
                  //return HomeView();
                  return HomeView();
              }
            }),
          ),
        ),
      ],
    ));
  }

  Drawer buildNavigationBar(MainViewModel mainViewModel, ThemeData theme,
      ColorScheme colorScheme, BuildContext context) {
    return Drawer(
      backgroundColor: colorScheme.background,
      child: Container(
        decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.grey.shade300))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView(children: [
            buildTitle(colorScheme),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2.5,
            ),
            buiildSubTitle(theme),
            Observer(builder: (_) {
              return NavItem(
                  onTap: () {
                    _onItemTapped(0, mainViewModel);
                  },
                  icon: Icons.home,
                  title: 'Ana Ekran',
                  isSelected: mainViewModel.bnbIndex == 0 ? true : false);
            }),
            Observer(builder: (_) {
              return NavItem(
                  onTap: () {
                    _onItemTapped(1, mainViewModel);
                  },
                  icon: Icons.sunny,
                  title: 'İzin',
                  isSelected: mainViewModel.bnbIndex == 1 ? true : false);
            }),
            if (clientType == ClientType.MANAGER)
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(2, mainViewModel);
                    },
                    icon: Icons.check,
                    title: 'Onay',
                    isSelected: mainViewModel.bnbIndex == 2 ? true : false);
              }),
            if (clientType != ClientType.EMPLOYEE)
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(3, mainViewModel);
                    },
                    icon: Icons.group,
                    title: 'Çalışanlar',
                    isSelected: mainViewModel.bnbIndex == 3 ? true : false);
              }),
            if (clientType == ClientType.ADMIN)
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(4, mainViewModel);
                    },
                    icon: Icons.handshake,
                    title: 'Departmanlar',
                    isSelected: mainViewModel.bnbIndex == 4 ? true : false);
              }),
            if (clientType == ClientType.ADMIN)
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(5, mainViewModel);
                    },
                    icon: Icons.edit,
                    title: 'Admin',
                    isSelected: mainViewModel.bnbIndex == 5 ? true : false);
              }),
            buildLogout(mainViewModel, context, theme, colorScheme)
          ]

              // selectedIndex: mainViewModel.bnbIndex,
              // onDestinationSelected: (index) => _onItemTapped(index, mainViewModel),
              ),
        ),
      ),
    );
  }

  SizedBox buiildSubTitle(ThemeData theme) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 5,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          clientType == ClientType.ADMIN
              ? "ADMIN"
              : clientType == ClientType.HR
                  ? "İK"
                  : clientType == ClientType.MANAGER
                      ? "YÖNETİCİ"
                      : "PERSONEL",
          style: theme.textTheme.bodyMedium!
              .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  SizedBox buildTitle(ColorScheme colorScheme) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 8,
      child: DrawerHeader(
        child: Text(
          "HR Manager",
          style: GoogleFonts.aBeeZee(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Observer buildLogout(MainViewModel mainViewModel, BuildContext context,
      ThemeData theme, ColorScheme colorScheme) {
    return Observer(builder: (_) {
      return NavItem(
          onTap: () {
            _onItemTapped(6, mainViewModel);
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
          icon: Icons.logout,
          title: 'Çıkış Yap',
          isSelected: mainViewModel.bnbIndex == 6 ? true : false);
    });
  }

  void _onItemTapped(int index, MainViewModel mainViewModel) {
    if (index != mainViewModel.bnbIndex) mainViewModel.setBnbIndex(index);
  }
}
