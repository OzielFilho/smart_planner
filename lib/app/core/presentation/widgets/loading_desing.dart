import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

class LoadingDesign extends StatelessWidget {
  final Color? color;
  const LoadingDesign({Key? key, this.color = ColorUtils.whiteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color!),
    );
  }
}
