// ignore_for_file: prefer_const_constructors

import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/settings_block.dart';
import 'package:al_huda/Presentation_layer/widgets/Ayah_block.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int chapterId;

  const ChapterView({required this.chapterId, super.key});

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());

    controller.createHeadValues(chapterId: chapterId);

    return WillPopScope(
      onWillPop: () async {
        controller.globalController.stopAudio();
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorsConst.blueLight,
        body: Column(
          children: [
            SettingsBlock(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeadBlock(headIndex: 0),
                    MyAyahBlock(headIndex: 0)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
