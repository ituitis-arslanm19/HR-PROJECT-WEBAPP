import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/service/new_time_off_service.dart';
import 'package:webapp/screen/viewModel/new_time_off_view_model.dart';

import '../../core/base/base_view.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/drop_down_input_text.dart';
import '../../core/widgets/other/input_text.dart';

class NewTimeOffView extends StatelessWidget {
  const NewTimeOffView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<NewTimeOffViewModel>(
      viewModel: NewTimeOffViewModel(
          NewTimeOffService(networkManager: NetworkManager()), context),
      onModelReady: (model) {
        model.init();
      },
      onPageBuilder: (context, viewModel, theme) => Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.READY:
            return buildNewTimeOff(
                theme, theme.colorScheme, viewModel, context);
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

  Column buildNewTimeOff(ThemeData theme, ColorScheme colorScheme,
      NewTimeOffViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Form(
                key: viewModel.formKeyNewTimeOff,
                child: Column(
                  children: [
                    InputText(
                      icon: const Icon(Icons.calendar_month),
                      textEditingController: viewModel.controllers[0],
                      hintText: "Başlangıç tarihi",
                      enabled: true,
                      validator: viewModel.inputTextValidator,
                      onTap: () =>
                          _showCalendar(context, viewModel.controllers[0]),
                    ),
                    InputText(
                      icon: const Icon(Icons.calendar_month),
                      textEditingController: viewModel.controllers[1],
                      hintText: "Bitiş",
                      enabled: true,
                      validator: viewModel.inputTextValidator,
                      onTap: () =>
                          _showCalendar(context, viewModel.controllers[1]),
                    ),
                    DropDownInputText(
                      textEditingController: viewModel.controllers[2],
                      hintText: "İzin Tipi",
                      validator: viewModel.inputTextValidator,
                      items: viewModel.timeOffTypeList!
                          .map((e) => e.name)
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6.0,
                      ),
                      child: SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                        child: Button(
                          onPressed: () {
                            viewModel.requestNewTimeOff();
                          },
                          text: "İZİN TALEBİ OLUŞTUR",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _showCalendar(
      BuildContext context, TextEditingController textEditingController) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        locale: const Locale('tr'),
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101),
        confirmText: "TAMAM");

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      textEditingController.text = formattedDate;
    }
  }
}
