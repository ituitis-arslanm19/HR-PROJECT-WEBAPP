import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/nav_item.dart';
import 'package:webapp/screen/view/access_location_view.dart';
import 'package:webapp/screen/view/admin_view.dart';
import 'package:webapp/screen/view/asset_type_view.dart';
import 'package:webapp/screen/view/asset_view.dart';
import 'package:webapp/screen/view/department_view.dart';
import 'package:webapp/screen/view/department_list_view.dart';
import 'package:webapp/screen/view/employee_view.dart';
import 'package:webapp/screen/view/employee_list_view.dart';
import 'package:webapp/screen/view/home_view.dart';
import 'package:webapp/screen/view/hr_view.dart';
import 'package:webapp/screen/view/reader_view.dart';
import 'package:webapp/screen/view/shift_view.dart';
import 'package:webapp/screen/view/site_view.dart';
import 'package:webapp/screen/view/time_off_approval_view.dart';
import 'package:webapp/screen/view/time_off_sign_view.dart';
import 'package:webapp/screen/view/time_off_type_view.dart';

import 'package:webapp/screen/view/time_off_view.dart';
import 'package:webapp/screen/viewModel/main_view_model.dart';

class MainView extends StatelessWidget {
  final List<ClientType> roles;
  const MainView({super.key, required this.roles});
  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = MainViewModel(context, SecureStorage());

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    SizeConfig().init(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: SizeConfig.screenHeight * 7 / 8,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                  width: 3 / 19 * SizeConfig.screenWidth,
                  child: buildNavigationBar(
                      mainViewModel, theme, colorScheme, context)),
              SizedBox(
                width: 16 / 19 * SizeConfig.screenWidth,
                child: Container(
                  color: Colors.grey[50],
                  child: Observer(builder: (context) {
                    switch (mainViewModel.bnbIndex) {
                      case 0:
                        return const HomeView();

                      case 1:
                        return const TimeOffView();

                      case 2:
                        return TimeOffApprovalView();

                      case 3:
                        //return TimeOffApprovalView();
                        return EmployeeListView(
                          clientType: roles.contains(ClientType.MANAGER)
                              ? ClientType.MANAGER
                              : ClientType.HR,
                        );

                      case 4:
                        //return TimeOffApprovalView();
                        return const DepartmentListView();

                      case 5:
                        return const HrView();

                      case 51:
                        return const EmployeeView();
                      case 52:
                        return const AssetView();
                      case 53:
                        return const AssetTypeView();
                      case 54:
                        return const TimeOffTypeView();
                      case 55:
                        return const TimeOffSignView();

                      case 6:
                        return const AdminView();

                      case 61:
                        return const DepartmentView();
                      case 62:
                        return const SiteView();
                      case 63:
                        return const AccessLocationView();
                      case 64:
                        return const ReaderView();
                      case 65:
                        return const ShiftView();

                      default:
                        //return HomeView();
                        return const HomeView();
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
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
            if (roles.contains(ClientType.MANAGER))
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(2, mainViewModel);
                    },
                    icon: Icons.check,
                    title: 'Onay',
                    isSelected: mainViewModel.bnbIndex == 2 ? true : false);
              }),
            if (roles.contains(ClientType.HR) ||
                roles.contains(ClientType.MANAGER))
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(3, mainViewModel);
                    },
                    icon: Icons.group,
                    title: 'Çalışanlar',
                    isSelected: mainViewModel.bnbIndex == 3 ? true : false);
              }),
            if (roles.contains(ClientType.ADMIN))
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(4, mainViewModel);
                    },
                    icon: Icons.handshake,
                    title: 'Departmanlar',
                    isSelected: mainViewModel.bnbIndex == 4 ? true : false);
              }),
            if (roles.contains(ClientType.HR))
              Observer(builder: (_) {
                return Column(
                  children: [
                    NavItem(
                        endIcon: !mainViewModel.hrSubMenu
                            ? Icons.arrow_right
                            : Icons.arrow_drop_down,
                        onTap: () {
                          mainViewModel
                              .changeHrSubMenu(!mainViewModel.hrSubMenu);
                        },
                        icon: Icons.edit,
                        title: 'İK',
                        isSelected: mainViewModel.bnbIndex == 5 ? true : false),
                    AnimatedSize(
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 200),
                      child: !mainViewModel.hrSubMenu
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : buildHrSubMenu(mainViewModel),
                    ),
                  ],
                );
              }),
            if (roles.contains(ClientType.ADMIN))
              Observer(builder: (_) {
                return Column(
                  children: [
                    NavItem(
                        endIcon: !mainViewModel.hrSubMenu
                            ? Icons.arrow_right
                            : Icons.arrow_drop_down,
                        onTap: () {
                          mainViewModel
                              .changeHrSubMenu(!mainViewModel.hrSubMenu);
                        },
                        icon: Icons.edit,
                        title: 'Admin',
                        isSelected: mainViewModel.bnbIndex == 5 ? true : false),
                    AnimatedSize(
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 200),
                      child: !mainViewModel.hrSubMenu
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : buildAdminSubMenu(mainViewModel),
                    ),
                  ],
                );
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

  Padding buildHrSubMenu(MainViewModel mainViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(51, mainViewModel);
              },
              title: 'Çalışan',
              isSelected: mainViewModel.bnbIndex == 51 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(52, mainViewModel);
              },
              icon: Icons.edit,
              title: 'Zimmet',
              isSelected: mainViewModel.bnbIndex == 52 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(53, mainViewModel);
              },
              icon: Icons.edit,
              title: 'Zimmet Tipi',
              isSelected: mainViewModel.bnbIndex == 53 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(54, mainViewModel);
              },
              icon: Icons.edit,
              title: 'İzin Tipi',
              isSelected: mainViewModel.bnbIndex == 54 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(55, mainViewModel);
              },
              icon: Icons.edit,
              title: 'İzin Takibi',
              isSelected: mainViewModel.bnbIndex == 55 ? true : false),
        ],
      ),
    );
  }

  Padding buildAdminSubMenu(MainViewModel mainViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(61, mainViewModel);
              },
              title: 'Departman',
              isSelected: mainViewModel.bnbIndex == 61 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(62, mainViewModel);
              },
              icon: Icons.edit,
              title: 'Alan',
              isSelected: mainViewModel.bnbIndex == 62 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(63, mainViewModel);
              },
              icon: Icons.edit,
              title: 'Giriş Noktası',
              isSelected: mainViewModel.bnbIndex == 63 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(64, mainViewModel);
              },
              icon: Icons.edit,
              title: 'Okuyucu',
              isSelected: mainViewModel.bnbIndex == 64 ? true : false),
          NavItem(
              isSubItem: true,
              onTap: () {
                _onItemTapped(65, mainViewModel);
              },
              icon: Icons.edit,
              title: 'Vardiya',
              isSelected: mainViewModel.bnbIndex == 65 ? true : false),
        ],
      ),
    );
  }

  SizedBox buiildSubTitle(ThemeData theme) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 5,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          roles.contains(ClientType.ADMIN)
              ? "ADMIN"
              : roles.contains(ClientType.HR)
                  ? "İK"
                  : roles.contains(ClientType.MANAGER)
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
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: Container(
                  height: SizeConfig.blockSizeVertical * 15,
                  width: SizeConfig.blockSizeVertical * 40,
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
                ),
              ),
            );
          },
          icon: Icons.logout,
          title: 'Çıkış Yap',
          isSelected: mainViewModel.bnbIndex == 7 ? true : false);
    });
  }

  void _onItemTapped(int index, MainViewModel mainViewModel) {
    if (index != mainViewModel.bnbIndex) mainViewModel.setBnbIndex(index);
  }
}
