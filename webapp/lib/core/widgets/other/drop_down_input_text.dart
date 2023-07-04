// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DropDownInputText extends StatefulWidget {
  final String? hintText;
  final List<String?> items;
  final String? title;
  final TextEditingController? textEditingController;
  final void Function(int)? onTap;
  final String? Function(String?)? validator;

  const DropDownInputText(
      {Key? key,
      this.hintText,
      required this.items,
      this.title,
      this.textEditingController,
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
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
            offset: Offset(0, size.height - 20),
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
                      TextFieldTapRegion(
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: IgnorePointer(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.items[index] ?? "Error",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (widget.textEditingController != null)
                                  widget.textEditingController!.text =
                                      widget.items[index] ?? "Error";
                                if (widget.onTap != null) widget.onTap!(index);
                                hideOverlay();
                                focusNode.unfocus();
                              },
                            )),
                      ),
                      const Divider(
                        thickness: 1,
                      )
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
      onTap: () {
        hideOverlay();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: widget.title != null ? 10 : 0),
              child: CompositedTransformTarget(
                link: layerLink,
                child: TextFormField(
                  validator: widget.validator,
                  focusNode: focusNode,
                  onTap: () {},
                  readOnly: true,
                  controller: widget.textEditingController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 1, color: Colors.grey.shade300)),
                      iconColor: Theme.of(context).colorScheme.primary,
                      prefixIcon: Icon(Icons.arrow_drop_down),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Theme.of(context).hintColor),
                      border: InputBorder.none,
                      labelText: widget.hintText ?? "Hata"),
                ),
              ),
            ),
            if (widget.title != null)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                      child: Text(widget.title!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
