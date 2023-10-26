import 'package:al_huda/Presentation_layer/controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/audio_state.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameBlock extends StatelessWidget {
  final int headIndex;
  int? guzNumber;
  NameBlock({
    this.guzNumber,
    required this.headIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.2,
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/surah/surah2.png',
              ),
              fit: BoxFit.fill)),
      child: Center(
        //  margin: EdgeInsets.fromLTRB(width * 0.28, 40, width * 0.28, 40),
        child: SizedBox(
          height: height * 0.6 * 0.2,
          width: width * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SurahNames(headIndex: headIndex),
              const MySeperator(),
              SurahControllers(
                headIndex: headIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MySeperator extends StatelessWidget {
  const MySeperator({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
        decoration: BoxDecoration(
            color: SeaColor.seaColorAccents.shade200,
            borderRadius: BorderRadius.circular(50)),
        width: 3,
        height: height * 0.2 * 0.45);
  }
}

class SurahControllers extends StatelessWidget {
  const SurahControllers({
    super.key,
    required this.headIndex,
  });

  final int headIndex;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HeadPlayButton(headIndex: headIndex),
        IconButton(
            onPressed: () {
              controller.chapterInfoVisibility(headIndex);
            },
            icon: Icon(
              Icons.info,
              size: 20,
              color: BlueColor.blueColor.shade400,
            )),
      ],
    );
  }
}

class SurahNames extends StatelessWidget {
  const SurahNames({
    super.key,
    required this.headIndex,
  });

  final int headIndex;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Expanded(
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              controller.model.value.heads.isEmpty
                  ? '...'
                  : controller.model.value.heads[headIndex].arabicName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: BlueColor.blueColor.shade400,
                  fontSize: TextSizes.medium),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            AutoSizeText(
              controller.model.value.heads.isEmpty
                  ? '...'
                  : controller.model.value.heads[headIndex].languageName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: BlueColor.blueColor.shade400,
                  fontSize: TextSizes.medium),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        );
      }),
    );
  }
}

class HeadPlayButton extends StatelessWidget {
  const HeadPlayButton({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    MyAnimationController aController = Get.find<MyAnimationController>();
    return Obx(() {
      if (controller.model.value.heads.isNotEmpty) {
        return Visibility(
            visible: controller.model.value.heads[headIndex].headSystemState ==
                AudioState.stopped,
            child: SizedBox(
              height: 25,
              child: IconButton(
                  onPressed: () {
                    controller.updateHeadSystem(headIndex, AudioState.playing);
                    controller.play(
                        urls:
                            controller.model.value.heads[headIndex].audiosPaths,
                        headIndex: headIndex);
                    controller.updateListMyAyahPlaying(headIndex);
                    aController.startAnimation();
                  },
                  icon: Icon(
                    Icons.play_arrow,
                    color: BlueColor.blueColor.shade400,
                    size: 30,
                  )),
            ));
      } else {
        return Container();
      }
    });
  }
}
