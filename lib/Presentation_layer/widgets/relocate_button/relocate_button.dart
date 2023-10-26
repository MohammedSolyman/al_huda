import 'package:al_huda/Presentation_layer/controllers/my_animation_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RelocateButton extends StatelessWidget {
  const RelocateButton({required this.headIndex, super.key});

  final int headIndex;
  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());
    MyAnimationController aController = Get.find<MyAnimationController>();
    return Obx(() {
      return Positioned(
        top: aController.model.value.relocateButtonTop,
        left: aController.model.value.relocateButtonLeft,
        child: SizedBox(
          height: aController.model.value.relocateButtonheight,
          width: aController.model.value.relocateButtonWidth,
          child: GestureDetector(
            onTap: () {
              controller.relocateToCurrentAyah(headIndex);
            },
            child: const MyRoundButton(),
          ),
        ),
      );
    });
  }
}

class MyRoundButton extends StatelessWidget {
  const MyRoundButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: BlueColor.blueColor.shade900,
            width: 4,
          ),
          gradient: LinearGradient(colors: [
            SeaColor.seaColorAccents.shade100,
            SeaColor.seaColorAccents.shade200,
            SeaColor.seaColorAccents.shade400,
            SeaColor.seaColorAccents.shade700,
          ]),
          boxShadow: [
            BoxShadow(
                color: BlueColor.blueColor.shade900,
                blurRadius: 5,
                offset: const Offset(1, 1))
          ]),
    );
  }
}
