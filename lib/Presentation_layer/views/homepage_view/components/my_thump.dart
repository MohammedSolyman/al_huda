import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyThumb extends StatelessWidget {
  const MyThumb(
      {required this.svgPath,
      required this.func,
      required this.text,
      super.key});

  final String svgPath;
  final Function func;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          func();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                // color: ColorsConst.yDarkBlueColor,
                color: PurpleColor.purpleColor.shade500,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 70, child: SvgPicture.asset(svgPath)),
                FittedBox(
                  child: Text(text,
                      style: TextStyle(
                          color: SkyColor.skyColor.shade200, fontSize: 18)),
                )
              ],
            ),
          ),
        ));
  }
}
