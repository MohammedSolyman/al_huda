import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLanguagesDialog(BuildContext context, [int? guzNumber]) async {
  GlobalController controller = Get.find<GlobalController>();

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  Widget widget = Container(
    width: width,
    height: height * 0.3,
    decoration: BoxDecoration(color: SkyColor.skyColor.shade900),
    child: SingleChildScrollView(
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
    ),
  );

  await Get.defaultDialog(
      title: 'choose translation',
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: SkyColor.skyColor.shade50),
      content: widget,
      backgroundColor: BlueColor.blueColor.shade700);
}
