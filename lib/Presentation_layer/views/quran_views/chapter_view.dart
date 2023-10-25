import 'package:al_huda/Presentation_layer/controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/audio_box/audio_box.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/ayah_block.dart';
import 'package:al_huda/Presentation_layer/widgets/relocate_button/relocate_button.dart';
import 'package:al_huda/Presentation_layer/widgets/settings_block.dart';
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
            const AudioBox(headIndex: 0),
            const RelocateButton(headIndex: 0)
          ]),
        ),
      ),
    );
  }
}

class MyGradient extends StatelessWidget {
  const MyGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.06,
        left: 0,
        child: Container(
          //    height: MediaQuery.of(context).size.height,
          height: 75,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 235, 240, 255),
                Color.fromARGB(240, 235, 240, 255),
                Color.fromARGB(220, 235, 240, 255),
                Color.fromARGB(150, 235, 240, 255),
                Color.fromARGB(50, 235, 240, 255),
                Color.fromARGB(0, 235, 240, 255),
              ])),
        ));
  }
}
