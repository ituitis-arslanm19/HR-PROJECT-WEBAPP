// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/approved_time_off.dart';

import '../../util/size_config.dart';

class TimeOffApprovalCard extends StatelessWidget {
  ApprovedTimeOff approvedTimeOff;
  final void Function(bool, int) onTap;

  TimeOffApprovalCard(
      {super.key, required this.approvedTimeOff, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle tittleStyle = theme.textTheme.bodySmall!
        .copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(0, 5), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
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
                            text: approvedTimeOff.startDate! +
                                " - " +
                                approvedTimeOff.endDate!,
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
                                  text: approvedTimeOff.timeOffType,
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
                            text: approvedTimeOff.firstName! +
                                " " +
                                approvedTimeOff.lastName!,
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
                                  bottomLeft: Radius.circular(20)))),
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
                                  bottomRight: Radius.circular(20)))),
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
      ),
    );
  }
}
