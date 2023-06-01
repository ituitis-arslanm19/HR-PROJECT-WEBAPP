import 'package:flutter/material.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/sign_history.dart';

import '../../util/size_config.dart';

class TimeOffCard extends StatelessWidget {
  final String startDate;
  final String endDate;
  final TimeOffStatus status;
  final String type;
  final String? name;
  final String? managerName;
  final bool? deleteEnable;
  void Function()? onPressed;

  TimeOffCard(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.type,
      this.managerName,
      this.name,
      this.deleteEnable,
      this.onPressed});

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
                    status == TimeOffStatus.APPROVED
                        ? Icons.check
                        : status == TimeOffStatus.PENDING
                            ? Icons.pending_actions
                            : Icons.close_rounded,
                    color: status == TimeOffStatus.APPROVED
                        ? Colors.green
                        : status == TimeOffStatus.PENDING
                            ? colorScheme.primary
                            : Colors.red,
                  ),
                  Text(
                      status == TimeOffStatus.APPROVED
                          ? " Onaylandı"
                          : status == TimeOffStatus.PENDING
                              ? " Onay Bekliyor"
                              : " Reddedildi",
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary)),
                  Expanded(child: SizedBox()),
                  deleteEnable == true
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: colorScheme.background,
                          ),
                          onPressed: onPressed,
                          child: Icon(
                            Icons.delete,
                            color: colorScheme.primary,
                          ))
                      : SizedBox(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            RichText(
              text: TextSpan(
                text: 'Başlangıç - Bitiş: ',
                style: tittleStyle,
                /*defining default style is optional */
                children: <TextSpan>[
                  TextSpan(
                    text: '$startDate - $endDate',
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'İzin Tipi: ',
                style: tittleStyle,
                /*defining default style is optional */
                children: <TextSpan>[
                  TextSpan(text: '$type', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                text: name != null ? 'İzin Alan: ' : 'Açıklama: ',
                style: tittleStyle,
                /*defining default style is optional */
                children: <TextSpan>[
                  TextSpan(
                      text: name != null
                          ? '$name'
                          : status == TimeOffStatus.APPROVED
                              ? " Onaylandı"
                              : status == TimeOffStatus.PENDING
                                  ? " Onay bekleniyor ($managerName)"
                                  : " Reddedildi ($managerName)",
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
