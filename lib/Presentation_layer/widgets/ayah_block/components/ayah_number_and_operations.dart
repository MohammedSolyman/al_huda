import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/components/coppying.dart';
import 'package:al_huda/Presentation_layer/widgets/ayah_block/components/my_ayah_audio_controllers.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyahNumberAndOperations extends StatelessWidget {
  const AyahNumberAndOperations({
    super.key,
    required this.index,
    required this.headIndex,
  });

  final int headIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AyahsPaths.ayah4))),
            child: Center(
              child: Text(
                controller.model.value.heads[headIndex].scripts[index].number
                    .toString(),
                style: const TextStyle(color: ColorsConst.yDarkBlueColor),
              ),
            ),
          ),
          Row(
            children: [
              MyAyahAudioControllers(
                headIndex: headIndex,
                index: index,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share,
                      color: ColorsConst.yDarkBlueColor)),
              Coppying(
                headIndex: headIndex,
                index: index,
              ),
            ],
          )
        ],
      ),
    );
  }
}
