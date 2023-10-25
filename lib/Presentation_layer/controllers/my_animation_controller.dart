import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAnimationModel {
//audio box button
  double audioBoxWidth = 0;
  double audioBoxHeight = 0;
  double audioBoxTop = 0;
  double audioBoxLeft = 0;

//relocate button
  double relocateButtonWidth = 0;
  double relocateButtonheight = 0;
  double relocateButtonTop = 0;
  double relocateButtonLeft = 0;
}

class MyAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //this controller is resposnible for animation of audio box and relocate button
  //audio box and relocate button appear when the user play the head of the
  //surrah, and reverse animation when:
  //1. the user hit stop button
  //2. the surrah play list finishes
  //3. the user hit back button

  Rx<MyAnimationModel> model = MyAnimationModel().obs;
  AnimationController? animationController;
  Animation<double>? audioBoxAnimationTop;
  Animation<double>? relocateAnimationTop;

  GlobalController globalController = Get.put(GlobalController());

  void startAnimation() {
    animationController!.forward();
  }

  void reverseAnimation() {
    animationController!.reverse();
  }

  void _updatingDimensions() {
    //1. getting dimesnions of the device.
    double deviceHeight = globalController.model.value.deviceHeight;
    double deviceWidth = globalController.model.value.deviceWidth;

    model.update((val) {
      //2. providing dimenstions, top, and left values to audio box.
      val!.audioBoxHeight = deviceHeight * 0.08;
      val.audioBoxWidth = deviceWidth * 0.4;
      val.audioBoxTop =
          -(deviceHeight * 0.08) - (deviceHeight * 0.01 /*extra top margin*/);
      val.audioBoxLeft = (deviceWidth - val.audioBoxWidth) / 2;

      //3. providing dimenstions, top, and left values to relocate button.
      val.relocateButtonheight = deviceHeight * 0.08;
      val.relocateButtonWidth = deviceHeight * 0.08;
      val.relocateButtonTop = -(deviceHeight * 0.08);
      val.relocateButtonLeft = 20;
    });
  }

  @override
  void onInit() {
    super.onInit();

    //1. getting dimesnions of the device.
    double deviceHeight = globalController.model.value.deviceHeight;

    //1. updating dimensions
    _updatingDimensions();

    //2. animation controller
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    //3. audio box
    //3.1 audio box tween
    Tween<double> audioBoxTweenTop = Tween(
        begin: -(deviceHeight * 0.08) - (deviceHeight * 0.01),
        end: deviceHeight * 0.01);

    //3.2 audio box animation
    audioBoxAnimationTop = audioBoxTweenTop.animate(animationController!);

    //4.relocate button
    //4.1 relocate button tween

    Tween<double> relocateButtonTweenTop = Tween(
        begin: -(deviceHeight * 0.08),
        end: (deviceHeight - model.value.relocateButtonheight - 50));

    //4.2 relocate button animation
    relocateAnimationTop = relocateButtonTweenTop.animate(animationController!);

    //5. updating values
    animationController!.addListener(() {
      model.update((val) {
        val!.audioBoxTop = audioBoxAnimationTop!.value;
        val.relocateButtonTop = relocateAnimationTop!.value;
      });
    });
  }
}
