import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';

class ArabicZekr extends StatelessWidget {
  const ArabicZekr({
    required this.arabicZekr,
    super.key,
  });

  final String arabicZekr;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(arabicZekr,
          style: TextStyle(
              color: BlueColor.blueColor.shade400, fontSize: TextSizes.medium)),
    );
  }
}
