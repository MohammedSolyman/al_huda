import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/audio_box/audio_box.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/ayah_block.dart';
import 'package:al_huda/Presentation_layer/widgets/my_gradient/my_gradient.dart';
import 'package:al_huda/Presentation_layer/widgets/relocate_button/relocate_button.dart';
import 'package:al_huda/Presentation_layer/widgets/settings_block.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/guzs_chapters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuzView extends StatelessWidget {
  const GuzView({required this.guzNumber, super.key});
  final int guzNumber;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    controller.createHeadValues(guzNumber: guzNumber);

    return WillPopScope(
      onWillPop: () async {
        controller.globalController.stopAudio();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: SkyColor.skyColor.shade500,
            body: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MySettings(guzNumber: guzNumber),
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
                            children: List.generate(
                                GuzsChaptersConstant
                                    .guzsChapters[guzNumber]!.length,
                                (headIndex) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        HeadBlock(
                                          headIndex: headIndex,
                                          guzNumber: guzNumber,
                                        ),
                                        MyAyahBlock(headIndex: headIndex)
                                      ],
                                    )),
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
            ])),
      ),
    );
  }
}
