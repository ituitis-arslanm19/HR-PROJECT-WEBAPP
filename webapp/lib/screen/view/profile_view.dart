// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/profile_card.dart';
import 'package:webapp/screen/service/profile_service.dart';
import 'package:webapp/screen/viewModel/profile_view_model.dart';

import '../../core/base/base_view.dart';
import '../../core/util/size_config.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModel:
          ProfileViewModel(ProfileService(networkManager: NetworkManager())),
      onModelReady: (model) {
        model.init();
      },
      onPageBuilder: (context, viewModel, theme) =>
          Observer(builder: (context) {
        switch (viewModel.dataState) {
          case DataState.READY:
            return buildPage(theme.colorScheme, theme, viewModel);
          case DataState.ERROR:
            return Center(child: Text("hata meydana geldi."));
          case DataState.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Center(child: Text("hata meydana geldi."));
        }
      }),
    );
  }

  SizedBox buildPage(
      ColorScheme colorScheme, ThemeData theme, ProfileViewModel viewModel) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 60,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: buildProfileImage(
                colorScheme,
                theme,
                viewModel.profile!.firstName![0] +
                    viewModel.profile!.lastName![0],
                viewModel),
          ),
          Expanded(
            flex: 5,
            child: buildProfileInfos(viewModel),
          ),
        ],
      ),
    );
  }

  Padding buildProfileInfos(ProfileViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ProfileCard(
            title: "Departman",
            value: viewModel.profile!.department ?? "Error",
          ),
          ProfileCard(
            title: "Doğum Günü",
            value: viewModel.profile!.birthDate ?? "Error",
          ),
          ProfileCard(
            title: "Başlangıç Tarihi",
            value: viewModel.profile!.startDate ?? "Error",
          ),
          ProfileCard(
            title: "Kalan İzin Günleri",
            value: viewModel.profile!.remainingTimeOffDays.toString(),
          ),
          // ProfileCard(
          //   title: "İşe Giriş Tarihi",
          //   value: viewModel.profile!. ?? "Error",
          // ),
        ],
      ),
    );
  }

  Container buildProfileImage(ColorScheme colorScheme, ThemeData theme,
      String nameInitials, ProfileViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCircularImage(colorScheme, theme, nameInitials),
            buildName(theme, viewModel),
            buildEmail(theme, viewModel)
          ],
        ),
      ),
    );
  }

  Text buildEmail(ThemeData theme, ProfileViewModel viewModel) {
    return Text(
      viewModel.profile!.email ?? "Error",
      style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
    );
  }

  Padding buildName(ThemeData theme, ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        viewModel.profile!.firstName ?? "Error",
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
