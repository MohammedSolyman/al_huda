import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class Sharing extends StatelessWidget {
  const Sharing({required this.headIndex, required this.index, super.key});

  final int headIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    String ayahNumber = controller
        .model.value.heads[headIndex].scripts[index].number
        .toString();
    String arabicScript =
        controller.model.value.heads[headIndex].scripts[index].script;
    String translation =
        controller.model.value.heads[headIndex].translations[index];
    String chapterName = controller.model.value.heads[headIndex].arabicName;
    String languageName = controller.model.value.heads[headIndex].languageName;

    return IconButton(
        onPressed: () async {
          await share(
              chapterName, languageName, ayahNumber, arabicScript, translation);
        },
        icon: const Icon(
          Icons.share,
          color: ColorsConst.yDarkBlueColor,
        ));
  }
}

Future<void> share(String chapterName, String languageName, String ayahNumber,
    String arabicScript, String translation) async {
  await Share.share("""  
${IntConstants.fromAlHudaapplication.tr}:

${IntConstants.surahName.tr}: $languageName - $chapterName,
  
${IntConstants.ayahNumber.tr}: $ayahNumber,

Ayah:$arabicScript

${IntConstants.translation.tr}: $translation
""");
}
