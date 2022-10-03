import 'package:flutter/material.dart';
import 'package:smart_planner/app/core/utils/color_utils.dart';

class ImageGetDesign extends StatelessWidget {
  const ImageGetDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.0),
      onTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 120,
            width: 110,
            decoration: BoxDecoration(
              border: Border.all(color: ColorUtils.whiteColor, width: 2),
              shape: BoxShape.circle,
            ),
          ),
          const Icon(
            Icons.camera_alt_outlined,
            size: 30,
            color: ColorUtils.whiteColor,
          ),
        ],
      ),
    );
  }
}
