// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:webapp/screen/model/approved_time_off.dart';

import '../../util/size_config.dart';

class TimeOffApprovalCard extends StatelessWidget {
  final ApprovedTimeOff approvedTimeOff;
  final void Function(bool, int) onTap;

  const TimeOffApprovalCard(
      {super.key, required this.approvedTimeOff, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle tittleStyle = theme.textTheme.bodySmall!
        .copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold);
    return Container(
      decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(
                          size: SizeConfig.blockSizeVertical * 5,
                          Icons.pending_actions,
                          color: colorScheme.primary,
                        ),
                        Text(" Onay Bekliyor",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Başlangıç - Bitiş: ',
                      style: tittleStyle,
                      /*defining default style is optional */
                      children: <TextSpan>[
                        TextSpan(
                          text: (approvedTimeOff.startDate ?? "Hata") +
                              " - " +
                              (approvedTimeOff.endDate ?? "Hata"),
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'İzin Tipi: ',
                          style: tittleStyle,
                          /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                                text: approvedTimeOff.timeOffType ?? "Hata",
                                style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'İzin Talep Eden: ',
                      style: tittleStyle,
                      /*defining default style is optional */
                      children: <TextSpan>[
                        TextSpan(
                          text: (approvedTimeOff.firstName ?? "Hata") +
                              " " +
                              (approvedTimeOff.lastName ?? "Hata"),
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () {
                      onTap(true, approvedTimeOff.id!);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10)))),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () {
                      onTap(false, approvedTimeOff.id!);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10)))),
                    child: Icon(
                      Icons.close,
                      color: colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
