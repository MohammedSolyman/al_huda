import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:al_huda/util/constants/reciters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySettings extends StatelessWidget {
  const MySettings({this.guzNumber, super.key});

  final int? guzNumber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: PopupMenuButton(
          color: SkyColor.skyColor.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: BlueColor.blueColor.shade700, width: 4),
          ),
          icon: Icon(
            Icons.settings,
            color: BlueColor.blueColor.shade700,
            size: 40,
          ),
          itemBuilder: (BuildContext context) {
            PopupMenuEntry<dynamic> a = PopupMenuItem(
              child: Text(
                IntConstants.chooseReciter.tr,
                style: TextStyle(
                    fontSize: TextSizes.normal,
                    color: BlueColor.blueColor.shade700),
              ),
              onTap: () async {
                await showRecitersDialog(context, guzNumber);
              },
            );

            PopupMenuEntry<dynamic> b = PopupMenuItem(
              child: Text(
                IntConstants.chooseTranslation.tr,
                style: TextStyle(
                    fontSize: TextSizes.normal,
                    color: BlueColor.blueColor.shade700),
              ),
              onTap: () async {
                await showTranslationDialog(context, guzNumber);
              },
            );

            return [a, b];
          }),
    );
  }
}

Future<void> showRecitersDialog(BuildContext context, [int? guzNumber]) async {
  QuranController qCont = Get.find<QuranController>();
  GlobalController controller = Get.find<GlobalController>();

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  Widget widget = Container(
    width: width * 0.75,
    height: height * 0.5,
    decoration: BoxDecoration(color: SkyColor.skyColor.shade900),
    child: Obx(() {
      return SingleChildScrollView(
        child: Column(
            children: List.generate(
                Reciters.reciters.length,
                (index) => RadioListTile<int>(
                    title: Text(Reciters.reciters[index].name),
                    value: Reciters.reciters[index].id,
                    groupValue: controller.model.value.selectedReciter,
                    onChanged: (int? id) {
                      qCont.updateReciter(id!, guzNumber: guzNumber);
                      Get.back();
                    }))),
      );
    }),
  );

  await Get.defaultDialog(
      title: IntConstants.chooseReciter.tr,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: SkyColor.skyColor.shade50),
      content: widget,
      backgroundColor: BlueColor.blueColor.shade700);
}

Future<void> showTranslationDialog(BuildContext context,
    [int? guzNumber]) async {
  QuranController controller = Get.find<QuranController>();

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  Widget widget = Container(
    width: width,
    height: height * 0.5,
    decoration: BoxDecoration(color: SkyColor.skyColor.shade900),
    child: Obx(() {
      if (controller.model.value.languageTranslations.isEmpty) {
        return const Text('there is no translations available');
      } else {
        return SingleChildScrollView(
          child: Column(
              children: List.generate(
                  controller.model.value.languageTranslations.length,
                  (index) => RadioListTile<int>(
                      title: SizedBox(
                        width: width * 0.4,
                        child: Text(controller
                            .model.value.languageTranslations[index].name!),
                      ),
                      value: controller
                          .model.value.languageTranslations[index].id!,
                      groupValue: controller.model.value.translationId,
                      onChanged: (int? id) {
                        controller.updateTranslationId(id!);
                        controller.updateTranslation(guzNumber: guzNumber);

                        Get.back();
                      }))),
        );
      }
    }),
  );

  await Get.defaultDialog(
      title: IntConstants.chooseTranslation.tr,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: SkyColor.skyColor.shade50),
      content: widget,
      backgroundColor: BlueColor.blueColor.shade700);
}
