import 'dart:io';

import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
          XFile arbXFile = await getArabicXFile(
            arabicName: chapterName,
            ayahNumber: ayahNumber,
            script: arabicScript,
          );

          XFile lngXFile = await getLanguageXFile(
              ayahNumber: ayahNumber,
              languageName: languageName,
              translation: translation);

          Share.shareXFiles([arbXFile, lngXFile]);
        },
        icon: const Icon(
          Icons.share,
          color: ColorsConst.yDarkBlueColor,
        ));
  }
}

Future<XFile> getArabicXFile({
  required String arabicName,
  required String ayahNumber,
  required String script,
}) async {
  ScreenshotController screenshotController = ScreenshotController();
  //1. arabic screenshot:
  //1.1 capturing screen
  Uint8List uint8List =
      await screenshotController.captureFromWidget(ArabicSharingTemplate(
    arabicName: arabicName,
    ayahNumber: ayahNumber,
    script: script,
  ));
  //1.2 getting a directory temp path
  Directory directory = await getApplicationDocumentsDirectory();
  String tempPath = directory.path;

  //1.3 getting a full temp path
  String tempFullPath = join(tempPath, 'arb$arabicName$ayahNumber.jpg');

  //1.4 creating and saving a file
  File file = File(tempFullPath);
  await file.writeAsBytes(uint8List);

  //1.5 creating the corresponding xFile
  XFile xfile = XFile(tempFullPath);

  return xfile;
}

Future<XFile> getLanguageXFile({
  required String ayahNumber,
  required String languageName,
  required String translation,
}) async {
  ScreenshotController screenshotController = ScreenshotController();
  //1. arabic screenshot:
  //1.1 capturing screen
  Uint8List uint8List =
      await screenshotController.captureFromWidget(LanguageSharingTemplate(
    languageName: languageName,
    ayahNumber: ayahNumber,
    translation: translation,
  ));
  //1.2 getting a directory temp path
  Directory directory = await getApplicationDocumentsDirectory();
  String tempPath = directory.path;

  //1.3 getting a full temp path
  String tempFullPath = join(tempPath, 'arb$languageName$ayahNumber.jpg');

  //1.4 creating and saving a file
  File file = File(tempFullPath);
  await file.writeAsBytes(uint8List);

  //1.5 creating the corresponding xFile
  XFile xfile = XFile(tempFullPath);

  return xfile;
}

class ArabicSharingTemplate extends StatelessWidget {
  const ArabicSharingTemplate(
      {required this.arabicName,
      required this.ayahNumber,
      required this.script,
      super.key});

  final String arabicName;
  final String script;
  final String ayahNumber;

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.find<GlobalController>();

    double surahFrameHeight = 180;
    double surahFrameWidth = controller.model.value.deviceWidth;
    double padding = 8;
    double nameAndAyahHeight = 95;
    double nameAndAyahWidth = surahFrameWidth * 0.5;

    return Material(
      child: Container(
        color: ColorsConst.blueLight,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: surahFrameHeight,
                    width: surahFrameWidth,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/surah/surah2.png',
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    top: (surahFrameHeight - nameAndAyahHeight - padding) / 2,
                    right:
                        (surahFrameWidth - nameAndAyahWidth - padding * 2) / 2,
                    child: SizedBox(
                      width: nameAndAyahWidth,
                      height: nameAndAyahHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            arabicName,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            'اية رقم $ayahNumber',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    script,
                    style: const TextStyle(
                        fontSize: 70, fontWeight: FontWeight.bold),
                    maxLines: 15,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text(IntConstants.fromAlHudaapplication.tr)
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageSharingTemplate extends StatelessWidget {
  const LanguageSharingTemplate(
      {required this.languageName,
      required this.ayahNumber,
      required this.translation,
      super.key});

  final String languageName;
  final String ayahNumber;
  final String translation;

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.find<GlobalController>();

    double surahFrameHeight = 180;
    double surahFrameWidth = controller.model.value.deviceWidth;
    double padding = 8;
    double nameAndAyahHeight = 95;
    double nameAndAyahWidth = surahFrameWidth * 0.5;
    return Material(
      child: Container(
        color: ColorsConst.blueLight,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: surahFrameHeight,
                    width: surahFrameWidth,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/surah/surah2.png',
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    top: (surahFrameHeight - nameAndAyahHeight - padding) / 2,
                    right:
                        (surahFrameWidth - nameAndAyahWidth - padding * 2) / 2,
                    child: SizedBox(
                      width: nameAndAyahWidth,
                      height: nameAndAyahHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            languageName,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          AutoSizeText(
                            '${IntConstants.ayahNumber.tr} $ayahNumber',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    translation,
                    style: const TextStyle(
                        fontSize: 70, fontWeight: FontWeight.bold),
                    maxLines: 40,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text(IntConstants.fromAlHudaapplication.tr)
            ],
          ),
        ),
      ),
    );
  }
}
