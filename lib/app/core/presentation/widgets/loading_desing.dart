import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

class LoadingDesign extends StatelessWidget {
  const LoadingDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(ColorUtils.whiteColor),
    );
  }
}
