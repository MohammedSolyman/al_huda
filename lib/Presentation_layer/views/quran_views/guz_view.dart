// import 'package:al_huda/Presentation_layer/controllers/quran_home_controller.dart';
// import 'package:al_huda/Presentation_layer/widgets/head.dart';
// import 'package:al_huda/data_layer/view_models/quran_home_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class GuzView extends StatelessWidget {
//   const GuzView({/ super.key});

//  // final List<GuzMapping> currentGuzMapping;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ListView.builder(
//               itemCount: currentGuzMapping.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Block(
//                   guzMapping: currentGuzMapping[index],
//                 );
//               })),
//     );
//   }
// }

// class Block extends StatelessWidget {
//   //Each block my represent a complete or incomplete chapter.
//  // final GuzMapping guzMapping;

//   const Block({
  
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     QuranHomeController controller = Get.find<QuranHomeController>();

//     return Column(
//       children: [
//         Head(
//             chapterId: guzMapping.chapterId,
//             chapterArabicName: controller
//                 .model.value.chaptersList[guzMapping.chapterId - 1].nameArabic,
//             chapterLanguageName: controller.model.value
//                 .chaptersList[guzMapping.chapterId - 1].translatedName.name,
//             firstAyah: guzMapping.firstAyahNumber,
//             lastAyah: guzMapping.lastAyahNumber),
//         Column(
//           children: List.generate(40, (ayahIndex) {
//             return Text('     ayah: ${ayahIndex + 1}');
//           }),
//         ),
//       ],
//     );
//   }
// }
