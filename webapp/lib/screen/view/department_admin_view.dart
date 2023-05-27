import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/button.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/search_field.dart';
import 'package:webapp/screen/service/access_location_service.dart';
import 'package:webapp/screen/service/department_service.dart';
import 'package:webapp/screen/view/access_location_detail_view.dart';
import 'package:webapp/screen/view/department_detail_view.dart';
import 'package:webapp/screen/viewModel/access_location_view_model.dart';
import 'package:webapp/screen/viewModel/department_view_model.dart';

class DepartmentView extends StatelessWidget {
  const DepartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    Color primaryColor = theme.colorScheme.primary;
    DepartmentViewModel viewmodel = DepartmentViewModel(
        DepartmentService(networkManager: NetworkManager(SecureStorage())));
    viewmodel.init();

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
                    viewmodel.filter(text);
                  },
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 10,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
                width: SizeConfig.blockSizeHorizontal * 10,
                child: Button(onPressed: () {}, text: "Yeni Ekle +"),
              )
            ],
          ),
        ),
        Observer(builder: (_) {
          switch (viewmodel.dataState) {
            case DataState.READY:
              return buildList(
                viewmodel,
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

  Expanded buildList(DepartmentViewModel viewModel, TextStyle textStyle,
      BuildContext context, Color primaryColor) {
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
                              child: DepartmentDetailView(
                                  buildContext: context, id: e.id)));
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
