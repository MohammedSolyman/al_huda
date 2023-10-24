import 'dart:io';

import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
              arabicName: chapterName,
              ayahNumber: ayahNumber,
              languageName: languageName,
              script: arabicScript,
              translation: translation);
        },
        icon: const Icon(
          Icons.share,
          color: ColorsConst.yDarkBlueColor,
        ));
  }
}

Future<void> share({
  required String arabicName,
  required String ayahNumber,
  required String languageName,
  required String script,
  required String translation,
}) async {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List uint8List =
      await screenshotController.captureFromWidget(ArabicSharingTemplate(
    arabicName: arabicName,
    ayahNumber: ayahNumber,
    script: script,
  ));

  XFile xFile = XFile.fromData(uint8List);
  await Share.shareXFiles([xFile]);
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
    double surahFrameHeight = 180;
    double surahFrameWidth = MediaQuery.of(context).size.width;
    double padding = 8;
    double nameAndAyahHeight = 95;
    double nameAndAyahWidth = MediaQuery.of(context).size.width * 0.5;

    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Container(
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
                        top: (surahFrameHeight - nameAndAyahHeight - padding) /
                            2,
                        right:
                            (surahFrameWidth - nameAndAyahWidth - padding * 2) /
                                2,
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
    double surahFrameHeight = 180;
    double surahFrameWidth = MediaQuery.of(context).size.width;
    double padding = 8;
    double nameAndAyahHeight = 95;
    double nameAndAyahWidth = MediaQuery.of(context).size.width * 0.5;

    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Container(
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
                        top: (surahFrameHeight - nameAndAyahHeight - padding) /
                            2,
                        right:
                            (surahFrameWidth - nameAndAyahWidth - padding * 2) /
                                2,
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
        ),
      ),
    );
  }
}
