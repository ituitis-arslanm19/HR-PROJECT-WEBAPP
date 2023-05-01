import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webapp/core/util/size_config.dart';

class PinField extends StatelessWidget {
  final List<TextEditingController> controllers;
  void Function()? onTap;

  PinField({super.key, this.onTap, required this.controllers});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineLarge!;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...controllers.map((e) => buildPin(context, e, textStyle))],
      ),
    );
  }

  Padding buildPin(BuildContext context,
      TextEditingController textEditingController, TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 12,
        width: SizeConfig.blockSizeHorizontal * 9,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 245, 245, 245),
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          style: textStyle,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: textEditingController,
          onTap: onTap,
          decoration: InputDecoration(
            counterText: "",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.red,
                )),
            errorMaxLines: 1,
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.red,
                )),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
