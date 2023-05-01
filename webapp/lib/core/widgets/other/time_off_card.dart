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

  const TimeOffCard(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.type,
      this.managerName,
      this.name});

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
                          color: colorScheme.primary))
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
