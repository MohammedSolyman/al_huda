import 'package:al_huda/Presentation_layer/controllers/quran_controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/quran_home_view/components/chapters_block.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/quran_home_view/components/guzs_block.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/quran_home_view/components/selection.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/quran_sort.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuranHomeView extends StatelessWidget {
  const QuranHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    QuranHomeController controller = Get.put(QuranHomeController());
    Get.put(MyAnimationController());
    controller.updateChaptersList();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
          backgroundColor: BlueColor.blueColor.shade500,
          body: Obx(() {
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Selection(),
                controller.model.value.quranSortValue == QuranSort.byChapter
                    ? const ChaptersBlock()
                    : const GuzsBlock()
              ],
            );
          })),
    );
  }
}
