import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasmalaBlock extends StatelessWidget {
  const BasmalaBlock({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      QuranController controller = Get.find<QuranController>();

      if (controller.model.value.heads.isEmpty) {
        return Container();
      } else {
        int firstAyahNumber =
            controller.model.value.heads[headIndex].scripts[0].number;
        int chapterId = controller.model.value.heads[headIndex].chapterId;

        if (firstAyahNumber == 1 && chapterId != 1 && chapterId != 9) {
          return Text('بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: BlueColor.blueColor.shade400,
                  fontSize: TextSizes.medium));
        } else {
          return Container();
        }
      }
    });
  }
}
