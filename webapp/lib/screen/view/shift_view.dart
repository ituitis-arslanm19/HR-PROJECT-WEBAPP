import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/service/shift_service.dart';
import 'package:webapp/screen/view/shift_detail_view.dart';
import 'package:webapp/screen/viewModel/shift_view_model.dart';

import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/data_grid.dart';
import '../../core/widgets/other/search_field.dart';

class ShiftView extends StatelessWidget {
  const ShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    Color primaryColor = theme.colorScheme.primary;
    ShiftViewModel viewModel =
        ShiftViewModel(ShiftService(networkManager: NetworkManager()));
    viewModel.init();

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
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
                width: SizeConfig.blockSizeHorizontal * 10,
                child: Button(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: ShiftDetailView(
                                    buildContext: context, id: null),
                              )).then((value) => viewModel.init());
                    },
                    text: "Yeni Ekle +"),
              )
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
      ShiftViewModel viewModel,
      TextStyle textStyle,
      BuildContext context,
      Color primaryColor,
      ThemeData theme,
      ColorScheme colorScheme) {
    return Expanded(
      child: DataGrid(
        deleteFunction: (id) {viewModel.delete(id);},
        onRowTap: (id) {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: ShiftDetailView(buildContext: context, id: id),
                  )).then((value) => viewModel.init());
        },
        titles: ["Id", "Ad", "Başlama Saati", "Bitiş Saati"],
        columnNames: ["id", "name", "startTime", "endTime"],
        dataSourceList: viewModel.shiftList!,
      ),
    );
  }
}
