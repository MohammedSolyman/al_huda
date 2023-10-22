// ignore_for_file: prefer_const_constructors

import 'package:al_huda/Presentation_layer/views/homepage_view/components/dialoge_languages.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';

class LanguagesSettings extends StatelessWidget {
  const LanguagesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: IconButton(
        onPressed: () {
          showLanguagesDialog(context);
        },
        icon: Icon(
          Icons.language,
          color: ColorsConst.yWhiteColor,
          size: 40,
        ),
      ),
    );
  }
}
