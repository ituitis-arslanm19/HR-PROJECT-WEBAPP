import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/search_field.dart';
import 'package:webapp/screen/service/department_service.dart';
import 'package:webapp/screen/view/department_detail_view.dart';
import 'package:webapp/screen/viewModel/department_view_model.dart';

class DepartmentView extends StatelessWidget {
  const DepartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    Color primaryColor = theme.colorScheme.primary;
    DepartmentViewModel viewModel = DepartmentViewModel(
        DepartmentService(networkManager: NetworkManager()));
    viewModel.init();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
                child: SearchField(
                  onChanged: (text) {
                    viewModel.filter(text);
                  },
                ),
              ),
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
                                child: DepartmentDetailView(
                                    buildContext: context, id: null),
                              )).then((value) => viewModel.init());
                    },
                    text: "Yeni Ekle +"),
              )
            ],
          ),
        ),
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
      DepartmentViewModel viewModel,
      TextStyle textStyle,
      BuildContext context,
      Color primaryColor,
      ThemeData theme,
      ColorScheme colorScheme) {
    return Expanded(
      child: ListWidget(
        titles: ["Id", "Ad", "Yönetici", "", ""],
        data: viewModel.departmentList!
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
                    e.managerName.toString(),
                    style: textStyle,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: DepartmentDetailView(
                                    buildContext: context, id: e.id),
                              )).then((value) => viewModel.init());
                    },
                    icon: Icon(
                      Icons.edit,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 15,
                            width: SizeConfig.blockSizeVertical * 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Silmek istediğinize emin misiniz?",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        if (await viewModel.delete(e.id!)) {
                                          viewModel.init();
                                          Navigator.of(context).pop();
                                        }
                                        ;
                                      },
                                      child: Text(
                                        "SİL",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: colorScheme.primary,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        "İPTAL",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
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
                      )
                    },
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
