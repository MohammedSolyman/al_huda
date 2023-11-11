import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';

class ZekrSharing extends StatelessWidget {
  const ZekrSharing(
      {required this.arabicZekr, required this.languageZekr, super.key});

  final String arabicZekr;
  final String languageZekr;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {},
        icon: Icon(Icons.share, color: BlueColor.blueColor.shade400));
  }
}
