import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';

class LanguageZekr extends StatelessWidget {
  const LanguageZekr({
    required this.languageZekr,
    super.key,
  });

  final String languageZekr;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        languageZekr,
        style: TextStyle(
            color: BlueColor.blueColor.shade400, fontSize: TextSizes.medium),
      ),
    );
  }
}
