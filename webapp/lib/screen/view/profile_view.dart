// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/profile_card.dart';
import 'package:webapp/screen/service/profile_service.dart';
import 'package:webapp/screen/viewModel/profile_view_model.dart';

import '../../core/util/size_config.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  ProfileViewModel profileViewModel = ProfileViewModel(
      ProfileService(networkManager: NetworkManager(SecureStorage())));
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    SizeConfig().init(context);
    profileViewModel.init();

    return Observer(builder: (context) {
      switch (profileViewModel.dataState) {
        case DataState.READY:
          return buildPage(colorScheme, theme);
        case DataState.ERROR:
          return Center(child: Text("hata meydana geldi."));
        case DataState.LOADING:
          return Center(
            child: CircularProgressIndicator(),
          );
        default:
          return Center(child: Text("hata meydana geldi."));
      }
    });
  }

  SizedBox buildPage(ColorScheme colorScheme, ThemeData theme) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 60,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: buildProfileImage(
                colorScheme,
                theme,
                profileViewModel.profile!.firstName![0] +
                    profileViewModel.profile!.lastName![0]),
          ),
          Expanded(
            flex: 5,
            child: buildProfileInfos(),
          ),
        ],
      ),
    );
  }

  Padding buildProfileInfos() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ProfileCard(
            tittle: "Departman",
            value: profileViewModel.profile!.department ?? "Error",
          ),
          ProfileCard(
            tittle: "Doğum Günü",
            value: profileViewModel.profile!.birthDate ?? "Error",
          ),
          ProfileCard(
            tittle: "Başlangıç Tarihi",
            value: profileViewModel.profile!.startDate ?? "Error",
          ),
          ProfileCard(
            tittle: "Kalan İzin Günleri",
            value: profileViewModel.profile!.remainingTimeOffDays.toString(),
          ),
          // ProfileCard(
          //   tittle: "İşe Giriş Tarihi",
          //   value: profileViewModel.profile!. ?? "Error",
          // ),
        ],
      ),
    );
  }

  Container buildProfileImage(
      ColorScheme colorScheme, ThemeData theme, String nameInitials) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCircularImage(colorScheme, theme, nameInitials),
            buildName(theme),
            buildEmail(theme)
          ],
        ),
      ),
    );
  }

  Text buildEmail(ThemeData theme) {
    return Text(
      profileViewModel.profile!.email ?? "Error",
      style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
    );
  }

  Padding buildName(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        profileViewModel.profile!.firstName ?? "Error",
        style: theme.textTheme.headlineMedium,
      ),
    );
  }

  Container buildCircularImage(
      ColorScheme colorScheme, ThemeData theme, String nameInitials) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.primary, width: 3)),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade400,
        child: Text(nameInitials.toUpperCase(),
            style: theme.textTheme.headlineLarge!
                .copyWith(color: colorScheme.background)),
        radius: SizeConfig.blockSizeVertical * 5,
      ),
    );
  }
}
