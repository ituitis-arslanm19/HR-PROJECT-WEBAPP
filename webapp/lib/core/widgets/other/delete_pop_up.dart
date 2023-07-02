import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class DeletePopUp extends StatelessWidget {
  final void Function()? deleteFunction;
  const DeletePopUp({super.key, this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return IconButton(
      onPressed: () => {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Container(
              height: SizeConfig.blockSizeVertical * 15,
              width: SizeConfig.blockSizeVertical * 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Silmek istediğinize emin misiniz?",
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          deleteFunction!();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "SİL",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "İPTAL",
                          style: theme.textTheme.bodyMedium!.copyWith(
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
        color: colorScheme.primary,
      ),
    );
  }
}
