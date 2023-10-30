import 'package:al_huda/Presentation_layer/controllers/quran_controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/audio_box/audio_box.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/ayah_block.dart';
import 'package:al_huda/Presentation_layer/widgets/my_gradient/my_gradient.dart';
import 'package:al_huda/Presentation_layer/widgets/relocate_button/relocate_button.dart';
import 'package:al_huda/Presentation_layer/widgets/settings_block.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block/head_block.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int chapterId;

  const ChapterView({required this.chapterId, super.key});

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    MyAnimationController aController = Get.find<MyAnimationController>();
    controller.createHeadValues(chapterId: chapterId);

    return WillPopScope(
      onWillPop: () async {
        controller.globalController.stopAudio();
        if (aController.animationController!.isCompleted) {
          aController.reverseAnimation();
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: SkyColor.skyColor.shade500,
          body: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const MySettings(),
                Expanded(
                  child: Scrollbar(
                    interactive: true,
                    radius: const Radius.circular(20),
                    thickness: 15,
                    thumbVisibility: false,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04),
                        child: Column(
                          children: [
                            HeadBlock(headIndex: 0),
                            const MyAyahBlock(headIndex: 0)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const MyGradient(),
            const AudioBox(),
            const RelocateButton()
          ]),
        ),
      ),
    );
  }
}
