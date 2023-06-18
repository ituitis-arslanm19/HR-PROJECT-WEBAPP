import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class InputText2 extends StatelessWidget {
  final String? hintText;
  final Icon? icon;
  final TextEditingController textEditingController;
  void Function()? onTap;

  InputText2(
      {super.key,
      this.hintText,
      this.icon,
      required this.textEditingController,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(hintText ?? "Hata")),
                TextFormField(
                  onTap: onTap,
                  controller: textEditingController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      iconColor: Theme.of(context).colorScheme.primary,
                      prefixIcon: icon),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
