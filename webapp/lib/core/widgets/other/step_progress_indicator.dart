import 'package:flutter/material.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/sign_history.dart';

import '../../util/size_config.dart';

class StepProgressIndicator extends StatelessWidget {
  final List<SignHistory> previousSteps;
  final List<String> futureSteps;
  final double? padding;

  const StepProgressIndicator(
      {super.key,
      required this.previousSteps,
      required this.futureSteps,
      this.padding});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Padding(
        padding: EdgeInsets.all(padding ?? SizeConfig.blockSizeVertical * 5),
        child: previousSteps.length + futureSteps.length == 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildOneStep(colorScheme, theme),
                  buildLastIcon(previousSteps, futureSteps)
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildMultipleStep(colorScheme, theme),
                      buildLastIcon(previousSteps, futureSteps),
                    ],
                  )
                ],
              ));
  }

  Row buildOneStep(ColorScheme colorScheme, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...previousSteps.map(
          (e) => Row(
            children: [
              buildStep(
                  (e.managerName ?? "Hata") + " " + (e.managerLastName ?? ""),
                  e.status,
                  colorScheme,
                  theme),
            ],
          ),
        ),
        ...futureSteps.map(
          (e) => Row(
            children: [
              buildStep(e, null, colorScheme, theme),
            ],
          ),
        )
      ],
    );
  }

  Icon buildLastIcon(
    List<SignHistory> previousSteps,
    List<String> futureSteps,
  ) {
    if (previousSteps.isEmpty) {
      return Icon(
        Icons.pending_outlined,
        color: Colors.grey,
        size: SizeConfig.blockSizeVertical * 8,
      );
    }
    return previousSteps.last.status == TimeOffStatus.APPROVED
        ? futureSteps.isEmpty
            ? Icon(
                Icons.check,
                color: Colors.green,
                size: SizeConfig.blockSizeVertical * 8,
              )
            : Icon(
                Icons.pending_outlined,
                color: Colors.grey,
                size: SizeConfig.blockSizeVertical * 8,
              )
        : Icon(
            Icons.close,
            color: Colors.red,
            size: SizeConfig.blockSizeVertical * 8,
          );
  }

  Row buildMultipleStep(ColorScheme colorScheme, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...previousSteps.map((e) => Row(
              children: [
                buildStep(
                    ((e.managerName ?? "Hata") +
                        " " +
                        (e.managerLastName ?? "")),
                    e.status,
                    colorScheme,
                    theme),
                Container(
                  height: 5,
                  width: SizeConfig.blockSizeHorizontal * 7,
                  color: e.status == TimeOffStatus.APPROVED
                      ? Colors.green
                      : Colors.grey,
                )
              ],
            )),
        //For the last element

        ...futureSteps.map(
          (e) => Row(
            children: [
              buildStep(e, null, colorScheme, theme),
              Container(
                  height: 5,
                  width: SizeConfig.blockSizeHorizontal * 7,
                  color: Colors.grey)
            ],
          ),
        )
      ],
    );
  }

  Column buildStep(String managerName, TimeOffStatus? status,
      ColorScheme colorScheme, ThemeData theme) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: getStepColor(status), width: 3)),
          child: CircleAvatar(
            backgroundColor: colorScheme.primary,
            radius: SizeConfig.blockSizeVertical * 5,
            child: Text(getInitials(managerName),
                style: theme.textTheme.headlineLarge!
                    .copyWith(color: colorScheme.background)),
          ),
        ),
        SizeConfig.verticalSpace(),
        Text((managerName)),
        SizeConfig.verticalSpace(),
        getSteptext(status)
      ],
    );
  }

  Color getStepColor(TimeOffStatus? status) {
    if (status == TimeOffStatus.APPROVED || status == TimeOffStatus.COMPLETED) {
      return Colors.green;
    } else if (status == null) {
      return Colors.grey;
    } else {
      return Colors.red;
    }
  }

  Text getSteptext(TimeOffStatus? status) {
    if (status == TimeOffStatus.APPROVED || status == TimeOffStatus.COMPLETED) {
      return const Text("Onaylandı", style: TextStyle(color: Colors.green));
    } else if (status == null) {
      return Text("Onay Bekliyor", style: TextStyle(color: Colors.grey));
    } else {
      return const Text("Reddedildi", style: TextStyle(color: Colors.red));
    }
  }

  String getInitials(String name) => name.isNotEmpty
      ? name
          .trim()
          .split(' ')
          .map((l) => l != "ve" ? l[0] : "")
          .take(2)
          .join()
          .toUpperCase()
      : '';
}
