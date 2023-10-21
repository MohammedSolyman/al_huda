import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GlobalController());
    return Scaffold(
      backgroundColor: ColorsConst.blueDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 15,
          ),
          const AppSettings(),
          SvgPicture.asset(PicturesPaths.nightpray),
          const SizedBox(
            height: 15,
          ),
          const MyThumbs(),
        ],
      ),
    );
  }
}

class MyThumbs extends StatelessWidget {
  const MyThumbs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.find<GlobalController>();

    return Expanded(
      flex: 4,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: ColorsConst.blueLight),
        child: GridView(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
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
              text: IntConstants.centers,
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
        ),
      ),
    );
  }
}

class AppSettings extends StatelessWidget {
  const AppSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.find<GlobalController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
            shape: Border.all(width: 3, color: Colors.black),
            icon: const Icon(
              Icons.language,
              size: 40,
              color: ColorsConst.yWhiteColor,
            ),
            itemBuilder: (BuildContext context) {
              PopupMenuEntry p1 = PopupMenuItem(
                child: Obx(() => Text('عربى',
                    style: controller.model.value.languageCode == 'ar'
                        ? const TextStyle(color: Colors.black, fontSize: 18)
                        : const TextStyle(color: Colors.grey, fontSize: 13))),
                onTap: () {
                  controller.updateMyLocale('ar');
                },
              );
              PopupMenuEntry p2 = PopupMenuItem(
                child: Obx(() => Text('french',
                    style: controller.model.value.languageCode == 'fr'
                        ? const TextStyle(color: Colors.black, fontSize: 18)
                        : const TextStyle(color: Colors.grey, fontSize: 13))),
                onTap: () {
                  controller.updateMyLocale('fr');
                },
              );
              PopupMenuEntry p3 = PopupMenuItem(
                child: Obx(() => Text('english',
                    style: controller.model.value.languageCode == 'en'
                        ? const TextStyle(color: Colors.black, fontSize: 18)
                        : const TextStyle(color: Colors.grey, fontSize: 13))),
                onTap: () {
                  controller.updateMyLocale('en');
                },
              );
              PopupMenuEntry p4 = PopupMenuItem(
                child: Obx(() => Text('spanish',
                    style: controller.model.value.languageCode == 'es'
                        ? const TextStyle(color: Colors.black, fontSize: 18)
                        : const TextStyle(color: Colors.grey, fontSize: 13))),
                onTap: () {
                  controller.updateMyLocale('es');
                },
              );
              List<PopupMenuEntry<dynamic>> x = [p1, p2, p3, p4];
              return x;
            }),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}

class MyThumb extends StatelessWidget {
  const MyThumb(
      {required this.svgPath,
      required this.func,
      required this.text,
      super.key});

  final String svgPath;
  final Function func;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          func();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: ColorsConst.yDarkBlueColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(svgPath),
                Text(text,
                    style: const TextStyle(
                        color: ColorsConst.yWhiteColor, fontSize: 18))
              ],
            ),
          ),
        ));
  }
}
