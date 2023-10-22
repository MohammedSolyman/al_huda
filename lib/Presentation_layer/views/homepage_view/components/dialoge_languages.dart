import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLanguagesDialog(BuildContext context, [int? guzNumber]) async {
  GlobalController controller = Get.find<GlobalController>();

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  Widget widget = Container(
    width: width,
    height: height * 0.3,
    decoration: const BoxDecoration(color: ColorsConst.blueLight),
    child: Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            RadioListTile(
                title: const Text('عربى'),
                value: 'ar',
                groupValue: controller.model.value.languageCode,
                onChanged: (String? s) {
                  controller.updateMyLocale(s!);
                  Get.back();
                }),
            RadioListTile(
                title: const Text('Français'),
                value: 'fr',
                groupValue: controller.model.value.languageCode,
                onChanged: (String? s) {
                  controller.updateMyLocale(s!);
                  Get.back();
                }),
            RadioListTile(
                title: const Text('English'),
                value: 'en',
                groupValue: controller.model.value.languageCode,
                onChanged: (String? s) {
                  controller.updateMyLocale(s!);
                  Get.back();
                }),
            RadioListTile(
                title: const Text('español'),
                value: 'es',
                groupValue: controller.model.value.languageCode,
                onChanged: (String? s) {
                  controller.updateMyLocale(s!);
                  Get.back();
                }),
          ],
        ),
      );
    }),
  );

  await Get.defaultDialog(
      title: 'choose translation',
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: ColorsConst.greyLight),
      content: widget,
      backgroundColor: ColorsConst.blueDark);
}
