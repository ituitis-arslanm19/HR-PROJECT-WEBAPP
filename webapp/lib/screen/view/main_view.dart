import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/nav_item.dart';
import 'package:webapp/screen/view/access_location_view.dart';
import 'package:webapp/screen/view/asset_type_view.dart';
import 'package:webapp/screen/view/asset_view.dart';
import 'package:webapp/screen/view/department_admin_view.dart';
import 'package:webapp/screen/view/department_list_view.dart';
import 'package:webapp/screen/view/employee_view.dart';
import 'package:webapp/screen/view/home_view.dart';
import 'package:webapp/screen/view/reader_view.dart';
import 'package:webapp/screen/view/shift_view.dart';
import 'package:webapp/screen/view/site_view.dart';
import 'package:webapp/screen/view/time_off_approval_view.dart';
import 'package:webapp/screen/view/time_off_sign_view.dart';
import 'package:webapp/screen/view/time_off_type_view.dart';

import 'package:webapp/screen/view/time_off_view.dart';
import 'package:webapp/screen/viewModel/main_view_model.dart';

import '../../core/base/base_view.dart';
import '../../core/widgets/other/scrollable_page.dart';

class MainView extends StatelessWidget {
  final List<ClientType> roles;
  const MainView({super.key, required this.roles});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BaseView<MainViewModel>(
      viewModel: MainViewModel(context, SecureStorage()),
      onModelReady: (model) {
        model.init();
        SizeConfig().init(context);
      },
      onPageBuilder: (context, viewModel, theme) => Scaffold(
          body: ScrollablePage(
        child: Row(
          children: [
            SizedBox(
                width: 3 / 19 * SizeConfig.screenWidth,
                child: buildNavigationBar(
                    viewModel, theme, theme.colorScheme, context)),
            SizedBox(
              width: 16 / 19 * SizeConfig.screenWidth,
              child: Container(
                color: Colors.grey[50],
                child: Observer(builder: (context) {
                  switch (viewModel.bnbIndex) {
                    case 0:
                      return const HomeView();

                    case 1:
                      return const TimeOffView();

                    case 21:
                      return TimeOffApprovalView();
                    case 22:
                      return const EmployeeView(
                        clientType: ClientType.MANAGER,
                      );

                    // case 3:
                    //   //return TimeOffApprovalView();
                    //   return EmployeeListView(
                    //     clientType: roles.contains(ClientType.MANAGER)
                    //         ? ClientType.MANAGER
                    //         : ClientType.HR,
                    //   );

                    case 4:
                      //return TimeOffApprovalView();
                      return const DepartmentListView();

                    case 51:
                      return const EmployeeView(
                        clientType: ClientType.HR,
                      );
                    case 52:
                      return const AssetView();
                    case 53:
                      return const AssetTypeView();
                    case 54:
                      return const TimeOffTypeView();
                    case 55:
                      return const TimeOffSignView();

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
      )),
    );
  }

  Drawer buildNavigationBar(MainViewModel viewModel, ThemeData theme,
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
                    _onItemTapped(0, viewModel);
                  },
                  icon: Icons.home,
                  title: 'Ana Ekran',
                  isSelected: viewModel.bnbIndex == 0 ? true : false);
            }),
            Observer(builder: (_) {
              return NavItem(
                  onTap: () {
                    _onItemTapped(1, viewModel);
                  },
                  icon: Icons.sunny,
                  title: 'İzin',
                  isSelected: viewModel.bnbIndex == 1 ? true : false);
            }),
            if (roles.contains(ClientType.MANAGER))
              Observer(builder: (_) {
                return buildMenu(
                    viewModel,
                    "Yönetici",
                    Icons.edit,
                    ["Onay", "Çalışanlar"],
                    21,
                    viewModel.changeManagerSubMenu,
                    viewModel.managerSubMenu);
              }),
            if (roles.contains(ClientType.ADMIN))
              Observer(builder: (_) {
                return NavItem(
                    onTap: () {
                      _onItemTapped(4, viewModel);
                    },
                    icon: Icons.handshake,
                    title: 'Departmanlar',
                    isSelected: viewModel.bnbIndex == 4 ? true : false);
              }),
            if (roles.contains(ClientType.HR))
              Observer(builder: (_) {
                return buildMenu(
                    viewModel,
                    "İK",
                    Icons.edit,
                    [
                      "Çalışan",
                      "Zimmet",
                      "Zimmet Tipi",
                      "İzin Tipi",
                      "İzin Takibi",
                    ],
                    51,
                    viewModel.changeHrSubMenu,
                    viewModel.hrSubMenu);
              }),
            if (roles.contains(ClientType.ADMIN))
              Observer(builder: (_) {
                return buildMenu(
                    viewModel,
                    "Admin",
                    Icons.edit,
                    [
                      "Departman",
                      "Alan",
                      "Giriş Noktası",
                      "Okuyucu",
                      "Vardiya"
                    ],
                    61,
                    viewModel.changeAdminSubMenu,
                    viewModel.adminSubMenu);
              }),
            buildLogout(viewModel, context, theme, colorScheme)
          ]

              // selectedIndex: viewModel.bnbIndex,
              // onDestinationSelected: (index) => _onItemTapped(index, viewModel),
              ),
        ),
      ),
    );
  }

  Column buildMenu(
      MainViewModel viewModel,
      String mainTitle,
      IconData mainIcon,
      List<String> subTitles,
      int startIndex,
      Function() onTapFunction,
      bool onTapVar) {
    return Column(
      children: [
        NavItem(
            endIcon: !onTapVar ? Icons.arrow_right : Icons.arrow_drop_down,
            onTap: () {
              onTapFunction();
            },
            icon: mainIcon,
            title: mainTitle,
            isSelected: viewModel.bnbIndex == startIndex / 10 ? true : false),
        AnimatedSize(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 200),
          child: !onTapVar
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : buildSubMenu(viewModel, subTitles, startIndex),
        ),
      ],
    );
  }

  Padding buildSubMenu(
      MainViewModel viewModel, List<String> titles, int startIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          ...titles.asMap().entries.map((e) {
            return NavItem(
                isSubItem: true,
                onTap: () {
                  _onItemTapped(startIndex + e.key, viewModel);
                },
                title: e.value,
                isSelected:
                    viewModel.bnbIndex == startIndex + e.key ? true : false);
          }),
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

  Observer buildLogout(MainViewModel viewModel, BuildContext context,
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
                            onPressed: () => viewModel.logout(),
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
          isSelected: viewModel.bnbIndex == 7 ? true : false);
    });
  }

  void _onItemTapped(int index, MainViewModel viewModel) {
    if (index != viewModel.bnbIndex) viewModel.setBnbIndex(index);
  }
}
