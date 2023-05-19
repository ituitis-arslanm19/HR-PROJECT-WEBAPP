// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webapp/screen/model/time_off_type.dart';

class DropDownInputText extends StatefulWidget {
  final String? hintText;
  final List<String?> items;
  bool selected;
  final TextEditingController textEditingController;
  final void Function()? onTap;
  String? Function(String?)? validator;

  DropDownInputText(
      {Key? key,
      this.hintText,
      required this.items,
      required this.selected,
      required this.textEditingController,
      this.onTap,
      this.validator})
      : super(key: key);

  @override
  State<DropDownInputText> createState() => _DropDownInputTextState();
}

class _DropDownInputTextState extends State<DropDownInputText> {
  OverlayEntry? overlayEntry;
  final layerLink = LayerLink();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      focusNode.hasFocus ? showOverlay() : hideOverlay();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
            offset: Offset(0, size.height - 3),
            link: layerLink,
            showWhenUnlinked: false,
            child: buildOverlay()),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Widget buildOverlay() => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    widget.items[index] ?? "Error",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              widget.textEditingController.text =
                                  widget.items[index] ?? "Error";
                              hideOverlay();
                              focusNode.unfocus();
                            },
                          )),
                      Divider()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => hideOverlay(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          children: [
            CompositedTransformTarget(
              link: layerLink,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  validator: widget.validator,
                  focusNode: focusNode,
                  onTap: () {},
                  readOnly: true,
                  controller: widget.textEditingController,
                  decoration: InputDecoration(
                      iconColor: Theme.of(context).colorScheme.primary,
                      prefixIcon: Icon(Icons.arrow_drop_down),
                      border: InputBorder.none,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Theme.of(context).hintColor),
                      labelText: widget.hintText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
