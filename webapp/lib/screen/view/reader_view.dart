
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/screen/service/reader_service.dart';
import 'package:webapp/screen/view/reader_detail_view.dart';
import 'package:webapp/screen/viewModel/reader_view_model.dart';

import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/search_field.dart';

class ReaderView extends StatelessWidget {
  const ReaderView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    Color primaryColor = theme.colorScheme.primary;
    ReaderViewModel viewModel = ReaderViewModel(
        ReaderService(networkManager: NetworkManager(SecureStorage())));
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
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
                width: SizeConfig.blockSizeHorizontal * 10,
                child: Button(onPressed: () {}, text: "Yeni Ekle +"),
              )
            ])),
        Observer(builder: (_) {
          switch (viewModel.dataState) {
            case DataState.READY:
              return buildList(
                viewModel,
                textStyle,
                context,
                primaryColor,
              );
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

  Expanded buildList(ReaderViewModel viewModel, TextStyle textStyle,
      BuildContext context, Color primaryColor) {
    return Expanded(
      child: ListWidget(
        titles: ["Id", "Ad", "Tip", "Yön", "", ""],
        data: viewModel.readerList!
            .map((e) => [
                  Text(
                    e.id.toString(),
                    style: textStyle,
                  ),
                  Text(
                    e.name.toString(),
                    style: textStyle,
                  ),
                  Text(
                    e.type.toString(),
                    style: textStyle,
                  ),
                  Text(
                    e.direction.toString(),
                    style: textStyle,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: ReaderDetailView(
                                    buildContext: context, id: e.id),
                              )).then((value) => viewModel.init());
                    },
                    icon: Icon(
                      Icons.edit,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: primaryColor,
                    ),
                  )
                ])
            .toList(),
      ),
    );
  }
}
