import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/network/network_manager.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/list_widget.dart';
import '../../core/widgets/other/search_field.dart';
import '../service/time_off_service.dart';
import '../viewModel/time_off_sign_view_model.dart';

class TimeOffSignView extends StatelessWidget {
  const TimeOffSignView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    Color primaryColor = theme.colorScheme.primary;
    TimeOffSignViewModel viewModel = TimeOffSignViewModel(
        TimeOffService(networkManager: NetworkManager(SecureStorage())),
        context);
    viewModel.init();
    print("build eedildi");

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                  child: SearchField(
                    onChanged: (text) {
                      viewModel.filter(text);
                    },
                  )),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 10,
              ),
            ])),
        Observer(builder: (_) {
          switch (viewModel.dataState) {
            case DataState.READY:
              return buildList(viewModel, textStyle, context, primaryColor,
                  theme, theme.colorScheme);
            case DataState.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              //return Center(child: Text("Hata meydana geldi"));
              return const Center(child: Text("Hata meydana geldi"));
          }
        }),
      ],
    );
  }

  Expanded buildList(
      TimeOffSignViewModel viewModel,
      TextStyle textStyle,
      BuildContext context,
      Color primaryColor,
      ThemeData theme,
      ColorScheme colorScheme) {
    return Expanded(
      child: ListWidget(
        titles: ["Id", "Ad", "Başlangıç Tarihi", "Bitiş Tarihi", "", ""],
        data: viewModel.timeOffList!
            .map((e) => [
                  Text(
                    e.id.toString(),
                    style: textStyle,
                  ),
                  Text(
                    e.firstName.toString() + " " + e.lastName.toString(),
                    style: textStyle,
                  ),
                  Text(
                    e.startDate.toString(),
                    style: textStyle,
                  ),
                  Text(
                    e.endDate.toString(),
                    style: textStyle,
                  ),
                  IconButton(
                    onPressed: () {
                      viewModel.signTimeOffSign(e.id!);
                    },
                    icon: Icon(
                      Icons.check,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      viewModel.printTimeOff(e.id!);
                    },
                    icon: Icon(
                      Icons.print,
                      color: primaryColor,
                    ),
                  ),
                ])
            .toList(),
      ),
    );
  }
}
