import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/Settings_block.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int chapterId;

  const ChapterView({required this.chapterId, super.key});

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());

    controller.createHeadValues(chapterId: chapterId);

    return Scaffold(
      body: Column(
        children: [
          SettingsBlock(headIndex: 0),
          HeadBlock(headIndex: 0),
          AyahBlock(headIndex: 0)
        ],
      ),
    );
  }
}
