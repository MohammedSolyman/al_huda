import 'package:al_huda/Presentation_layer/controllers/chapter_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int id;

  const ChapterView({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.put(ChapterViewController());
    controller.updateIdGetInfo(id);
    return const Scaffold(
      body: Column(
        children: [Text('chapter infromation'), Info()],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    ChapterViewController controller = Get.find<ChapterViewController>();

    return Obx(() {
      if (controller.model.value.chapterInfo.isEmpty) {
        return const CircularProgressIndicator();
      } else {
        return Text(controller.model.value.chapterInfo);
      }
    });
  }
}
