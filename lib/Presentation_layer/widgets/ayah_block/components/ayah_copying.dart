import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class AyahCopying extends StatelessWidget {
  const AyahCopying({required this.headIndex, required this.index, super.key});

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
          await copyAyahToClipbaord(
              chapterName, languageName, ayahNumber, arabicScript, translation);
        },
        icon: Icon(Icons.copy, color: BlueColor.blueColor.shade400));
  }
}

Future<void> copyAyahToClipbaord(String chapterName, String languageName,
    String ayahNumber, String arabicScript, String translation) async {
  await Clipboard.setData(ClipboardData(text: """  
${IntConstants.fromAlHudaapplication.tr}:

${IntConstants.surahName.tr}: $languageName - $chapterName,
  
${IntConstants.ayahNumber.tr}: $ayahNumber,

Ayah:$arabicScript

${IntConstants.translation.tr}: $translation
"""));

  GetSnackBar snackbar = const GetSnackBar(
    message: 'ayah was coppied',
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(snackbar);
}
