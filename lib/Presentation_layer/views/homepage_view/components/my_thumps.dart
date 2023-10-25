import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/views/homepage_view/components/my_thump.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyThumbs extends StatelessWidget {
  const MyThumbs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.find<GlobalController>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            // color: ColorsConst.blueLight
            color: SkyColor.skyColor.shade500),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = (constraints.maxWidth) / 2;
            double height = (constraints.minHeight) / 3;

            return GridView(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: width / height,
              ),
              children: [
                MyThumb(
                  svgPath: PicturesPaths.quran,
                  func: controller.goToQuranHome,
                  text: IntConstants.holyQuran.tr,
                ),
                MyThumb(
                  svgPath: PicturesPaths.islamicCenters,
                  func: controller.goToQuranHome,
                  text: IntConstants.centers.tr,
                ),
                MyThumb(
                  svgPath: PicturesPaths.azkar,
                  func: controller.goToQuranHome,
                  text: IntConstants.athkar.tr,
                ),
                MyThumb(
                  svgPath: PicturesPaths.learnIslam,
                  func: controller.goToQuranHome,
                  text: IntConstants.lessons.tr,
                ),
                MyThumb(
                  svgPath: PicturesPaths.quran,
                  func: controller.goToQuranHome,
                  text: IntConstants.lessons.tr,
                ),
                MyThumb(
                  svgPath: PicturesPaths.quran,
                  func: controller.goToQuranHome,
                  text: IntConstants.lessons.tr,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
