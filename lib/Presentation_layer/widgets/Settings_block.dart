import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/reciters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsBlock extends StatelessWidget {
  SettingsBlock(
      {this.guzNumber,
//  required this.headIndex,
      super.key});

  // final int headIndex;
  int? guzNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TranslationSettings(
              //  headIndex: headIndex,
              guzNumber: guzNumber),
          RecitersSettings(

              // headIdex: headIndex,

              guzNumber: guzNumber)
        ],
      ),
    );
  }
}

class TranslationSettings extends StatelessWidget {
  TranslationSettings(
      {this.guzNumber,
      // required this.headIndex,
      super.key});
  // final int headIndex;
  int? guzNumber;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return PopupMenuButton(
        icon: const Icon(
          Icons.school,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          if (controller.model.value.languageTranslations.isEmpty) {
            List<PopupMenuEntry<dynamic>> x = [
              const PopupMenuItem(
                  child: Text('there is no translations available'))
            ];

            return x;
          } else {
            List<PopupMenuEntry<dynamic>> x = List.generate(
                controller.model.value.languageTranslations.length, (index) {
              return PopupMenuItem(
                child: Text(
                    controller.model.value.languageTranslations[index].name!),
                onTap: () {
                  controller.updateTranslationId(
                      controller.model.value.languageTranslations[index].id!);
                  controller.updateTranslation(guzNumber: guzNumber);
                },
              );
            });

            return x;
          }
        });
  }
}

class RecitersSettings extends StatelessWidget {
  RecitersSettings(
      {this.guzNumber,
      //required this.headIdex,
      super.key});

  // final int headIdex;
  int? guzNumber;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();
    return PopupMenuButton(
        icon: const Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<dynamic>> x =
              List.generate(Reciters.reciters.length, (index) {
            return PopupMenuItem(
              child: Text(Reciters.reciters[index].name),
              onTap: () async {
                await controller.updateReciter(Reciters.reciters[index].id,
                    guzNumber: guzNumber);
              },
            );
          });
          return x;
        });
  }
}
