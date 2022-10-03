import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

class ButtonWidgetCustom extends StatelessWidget {
  final Color color;
  final Function() action;
  final Widget content;
  const ButtonWidgetCustom(
      {Key? key,
      this.color = ColorUtils.whiteColor,
      required this.action,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: MediaQuery.of(context).size.height * 0.05,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: action,
      child: content,
    );
  }
}
