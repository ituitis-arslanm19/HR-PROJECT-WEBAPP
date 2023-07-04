import 'package:flutter/material.dart';

class InputText2 extends StatelessWidget {
  final String? hintText;
  final Icon? icon;
  final TextEditingController textEditingController;
  final void Function()? onTap;

  const InputText2(
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
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  onTap: onTap,
                  controller: textEditingController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1, color: Colors.grey.shade300)),
                      iconColor: Theme.of(context).colorScheme.primary,
                      prefixIcon: icon),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                      child: Text(hintText ?? "Hata",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
