// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'package:webapp/core/widgets/other/drop_down_input_text.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/screen/model/department_history.dart';
import 'package:webapp/screen/model/shift.dart';

import '../../core/util/size_config.dart';
import '../../core/widgets/other/input_text2.dart';
import '../model/department.dart';

class DepartmentHistoryDetailView extends StatelessWidget {
  final BuildContext buildContext;
  final Function(DepartmentHistory) onSubmit;
  final List<Shift> shiftList;
  final List<Department> departmentList;
  late List<TextEditingController> controllerList;
  late int shiftId;
  DepartmentHistoryDetailView({
    Key? key,
    required this.buildContext,
    required this.onSubmit,
    required this.shiftList,
    required this.departmentList,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    controllerList = List.generate(5, (i) => TextEditingController());

    return buildPopUp(context);
  }

  buildPopUp(BuildContext context) {
    return Observer(builder: (_) {
      return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 30,
        height: SizeConfig.blockSizeVertical * 45,
        child: SimpleContainer(
          padding: 0,
          title: "Departman Geçmişi",
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: DropDownInputText(
                        title: "Departman",
                        textEditingController: controllerList[0],
                        items: departmentList.map((e) => e.name).toList(),
                        onTap: (index) {
                          shiftId = shiftList[index].id!;
                        },
                      )),
                  Expanded(
                      flex: 5,
                      child: InputText2(
                          icon: const Icon(Icons.control_point),
                          hintText: "Pozisyon",
                          textEditingController: controllerList[1])),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropDownInputText(
                        title: "Vardiya",
                        textEditingController: controllerList[2],
                        items: shiftList.map((e) => e.name).toList(),
                        onTap: (index) {
                          shiftId = shiftList[index].id!;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: InputText2(
                          onTap: () =>
                              _showCalendar(buildContext, controllerList[3]),
                          icon: const Icon(Icons.date_range),
                          hintText: "Başlengıç Tarihi",
                          textEditingController: controllerList[3])),
                  Expanded(
                      flex: 5,
                      child: InputText2(
                          onTap: () =>
                              _showCalendar(buildContext, controllerList[4]),
                          icon: const Icon(Icons.date_range),
                          hintText: "Ayrılış",
                          textEditingController: controllerList[4])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.04,
                      width: SizeConfig.screenWidth * 0.05,
                      child: TextButton(
                          onPressed: () async {
                            onSubmit(DepartmentHistory(
                              departmentName: controllerList[0].text,
                              positionName: controllerList[1].text,
                              shiftName: controllerList[2].text,
                              shiftId: shiftId,
                              startDate: controllerList[3].text,
                              endDate: controllerList[4].text,
                            ));
                            Navigator.pop(buildContext);
                          },
                          child: const Text("Kaydet",
                              style: TextStyle(color: Colors.white)),
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(buildContext).colorScheme.primary)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.04,
                      width: SizeConfig.screenWidth * 0.05,
                      child: TextButton(
                          onPressed: () => Navigator.of(buildContext).pop(),
                          child: const Text("İptal",
                              style: TextStyle(color: Colors.white)),
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(buildContext).colorScheme.primary)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
