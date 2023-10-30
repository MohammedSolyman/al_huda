import 'package:al_huda/Presentation_layer/controllers/azkar_controllers/azkar_home_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/views/homepage_view/components/languages_settings.dart';
import 'package:al_huda/Presentation_layer/views/homepage_view/components/my_thumps.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.put(GlobalController());
    AzkarHomeController zController = Get.put(AzkarHomeController());
    zController.getLangAzkar(context);
    zController.getArabicAzkar(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    controller.updateDeviceDimensions(height, width);

    return SafeArea(
      child: Scaffold(
        //  backgroundColor: ColorsConst.blueDark,
        backgroundColor: BlueColor.blueColor.shade500,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 15,
            ),
            const LanguagesSettings(),
            SvgPicture.asset(PicturesPaths.nightpray),
            const SizedBox(
              height: 15,
            ),
            const MyThumbs(),
          ],
        ),
      ),
    );
  }
}
