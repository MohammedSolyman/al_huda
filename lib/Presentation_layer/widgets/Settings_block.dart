import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/reciters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySettings extends StatelessWidget {
  MySettings({this.guzNumber, super.key});

  int? guzNumber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: PopupMenuButton(
          icon: const Icon(
            Icons.settings,
            color: ColorsConst.blueDark,
            size: 40,
          ),
          itemBuilder: (BuildContext context) {
            PopupMenuEntry<dynamic> a = PopupMenuItem(
              child: Text('choosr reciter'),
              onTap: () async {
                await showRecitersDialog(context, guzNumber);
              },
            );

            PopupMenuEntry<dynamic> b = PopupMenuItem(
              child: Text('choosr translation'),
              onTap: () async {
                await showTranslationDialog(context, guzNumber);
              },
            );

            return [a, b];
          }),
    );
  }
}

// class TranslationSettings extends StatelessWidget {
//   TranslationSettings(
//       {this.guzNumber,
//       // required this.headIndex,
//       super.key});
//   // final int headIndex;
//   int? guzNumber;
//   @override
//   Widget build(BuildContext context) {
//     QuranController controller = Get.find<QuranController>();

//     return PopupMenuButton(
//         icon: const Icon(
//           Icons.school,
//           color: Colors.white,
//         ),
//         itemBuilder: (BuildContext context) {
//           if (controller.model.value.languageTranslations.isEmpty) {
//             List<PopupMenuEntry<dynamic>> x = [
//               const PopupMenuItem(
//                   child: Text('there is no translations available'))
//             ];

//             return x;
//           } else {
//             List<PopupMenuEntry<dynamic>> x = List.generate(
//                 controller.model.value.languageTranslations.length, (index) {
//               return PopupMenuItem(
//                 child: Text(
//                     controller.model.value.languageTranslations[index].name!),
//                 onTap: () {
//                   controller.updateTranslationId(
//                       controller.model.value.languageTranslations[index].id!);
//                   controller.updateTranslation(guzNumber: guzNumber);
//                 },
//               );
//             });

//             return x;
//           }
//         });
//   }
// }

// class RecitersSettings extends StatelessWidget {
//   RecitersSettings({this.guzNumber, super.key});

//   int? guzNumber;
//   @override
//   Widget build(BuildContext context) {
//     QuranController controller = Get.find<QuranController>();
//     return PopupMenuButton(
//         icon: const Icon(
//           Icons.account_circle,
//           color: Colors.white,
//         ),
//         itemBuilder: (BuildContext context) {
//           List<PopupMenuEntry<dynamic>> x =
//               List.generate(Reciters.reciters.length, (index) {
//             return PopupMenuItem(
//               child: Text(Reciters.reciters[index].name),
//               onTap: () async {
//                 await controller.updateReciter(Reciters.reciters[index].id,
//                     guzNumber: guzNumber);
//               },
//             );
//           });
//           return x;
//         });
//   }
// }

Future<void> showRecitersDialog(BuildContext context, [int? guzNumber]) async {
  QuranController qCont = Get.find<QuranController>();
  GlobalController controller = Get.find<GlobalController>();

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  Widget widget = Container(
    width: width * 0.75,
    height: height * 0.5,
    decoration: BoxDecoration(color: ColorsConst.blueLight),
    child: Obx(() {
      return SingleChildScrollView(
        child: Column(
            children: List.generate(
                Reciters.reciters.length,
                (index) => Row(
                      children: [
                        Radio<int>(
                            value: Reciters.reciters[index].id,
                            groupValue: controller.model.value.selectedReciter,
                            onChanged: (int? id) {
                              qCont.updateReciter(id!, guzNumber: guzNumber);
                              Get.back();
                            }),
                        Text(Reciters.reciters[index].name)
                      ],
                    ))),
      );
    }),
  );

  await Get.defaultDialog(
      title: 'choose reciter',
      titleStyle:
          TextStyle(fontWeight: FontWeight.bold, color: ColorsConst.greyLight),
      content: widget,
      backgroundColor: ColorsConst.blueDark);
}

Future<void> showTranslationDialog(BuildContext context,
    [int? guzNumber]) async {
  QuranController controller = Get.find<QuranController>();

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  Widget widget = Container(
    width: width,
    height: height * 0.5,
    decoration: BoxDecoration(color: ColorsConst.blueLight),
    child: Obx(() {
      if (controller.model.value.languageTranslations.isEmpty) {
        return Text('there is no translations available');
      } else {
        return SingleChildScrollView(
          child: Column(
              children: List.generate(
                  controller.model.value.languageTranslations.length,
                  (index) => Row(
                        children: [
                          Radio<int>(
                              value: controller
                                  .model.value.languageTranslations[index].id!,
                              groupValue: controller.model.value.translationId,
                              onChanged: (int? id) {
                                controller.updateTranslationId(id!);
                                controller.updateTranslation(
                                    guzNumber: guzNumber);

                                Get.back();
                              }),
                          SizedBox(
                            width: width * 0.4,
                            child: Text(controller
                                .model.value.languageTranslations[index].name!),
                          )
                        ],
                      ))),
        );
      }
    }),
  );

  await Get.defaultDialog(
      title: 'choose translation',
      titleStyle:
          TextStyle(fontWeight: FontWeight.bold, color: ColorsConst.greyLight),
      content: widget,
      backgroundColor: ColorsConst.blueDark);
}
