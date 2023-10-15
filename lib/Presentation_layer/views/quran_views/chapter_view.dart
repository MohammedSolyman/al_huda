import 'package:al_huda/Presentation_layer/controllers/quran_controller.dart';
import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/widgets/head.dart';
import 'package:al_huda/util/constants/reciters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatelessWidget {
  final int chapterId;

  const ChapterView({required this.chapterId, super.key});

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.put(QuranController());

    controller.createHeadValues([chapterId], true);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Head(headIndex: 0),
          ChapterAyahs(headIndex: 0)
        ],
      ),
    );
  }
}

class ChapterAyahs extends StatelessWidget {
  const ChapterAyahs({required this.headIndex, super.key});
  final int headIndex;

  @override
  Widget build(BuildContext context) {
    QuranController controller = Get.find<QuranController>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          children: [
            Obx(() {
              if (controller.model.value.heads.isEmpty) {
                return CircularProgressIndicator();
              } else {
                if (controller.model.value.heads[headIndex].scripts!.isEmpty) {
                  return Text('...');
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: controller
                            .model.value.heads[headIndex].scripts!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                //  color: controller.getAyahColor(index + 1),
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(controller.model.value.heads[headIndex]
                                        .scripts![index].number
                                        .toString()),
                                    Expanded(
                                      child: Text(
                                          controller
                                              .model
                                              .value
                                              .heads[headIndex]
                                              .scripts![index]
                                              .script,
                                          textDirection: TextDirection.rtl),
                                    ),
                                    Column(
                                      children: [
                                        // VerseAudioControllers(
                                        //     chapterId: chapterId,
                                        //     ayahNumber: index + 1),
                                        // Visibility(
                                        //     visible: controller
                                        //             .model.value.translationId !=
                                        //         0,
                                        // child: IconButton(
                                        //     onPressed: () {
                                        //       controller.toggleTranslationState(
                                        //           index + 1);
                                        //       controller
                                        //           .getSpecifcAyahTranslation(
                                        //               chapterId, index + 1);
                                        //     },
                                        //     icon: const Icon(Icons.school))
                                        //  )
                                      ],
                                    )
                                  ],
                                ),
                                // TranslationBock(
                                //     chapterId: chapterId, ayahId: index + 1),
                              ],
                            ),
                          );
                        }),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}

// class VerseAudioControllers extends StatelessWidget {
//   const VerseAudioControllers(
//       {required this.ayahNumber, required this.chapterId, super.key});

//   final int ayahNumber;
//   final int chapterId;

//   @override
//   Widget build(BuildContext context) {
//     QuranController controller = Get.find<QuranController>();

//     if (controller.model.value.chapterPlaying != chapterId) {
//       if (controller.model.value.ayahPlaying == ayahNumber) {
//         return Row(
//           children: [
//             VersePauseResume(ayahNumber),
//             IconButton(
//                 onPressed: () {
//                   controller.stop();
//                 },
//                 icon: const Icon(Icons.stop)),
//           ],
//         );
//       } else {
//         return IconButton(
//             onPressed: () {
//               //  controller.playAyah(ayahNumber);
//             },
//             icon: const Icon(Icons.play_arrow));
//       }
//     } else {
//       return Container();
//     }
//   }
// }

// class VersePauseResume extends StatelessWidget {
//   const VersePauseResume(this.ayahNumber, {super.key});
//   final int ayahNumber;

//   @override
//   Widget build(BuildContext context) {
//     QuranController controller = Get.find<QuranController>();

//     if (controller.model.value.ayahPaused == ayahNumber) {
//       return IconButton(
//           onPressed: () {
//             controller.resume();
//           },
//           icon: const Icon(Icons.play_circle));
//     } else {
//       return IconButton(
//           onPressed: () {
//             controller.pause(ayahNumber);
//           },
//           icon: const Icon(Icons.pause));
//     }
//   }
// }

class RecitersSettings extends StatelessWidget {
  const RecitersSettings({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalController gController = Get.find<GlobalController>();
    QuranController quranController = Get.find<QuranController>();
    return PopupMenuButton(
        icon: const Icon(Icons.account_circle),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<dynamic>> x =
              List.generate(Reciters.reciters.length, (index) {
            return PopupMenuItem(
              child: Text(Reciters.reciters[index].name),
              onTap: () async {
                // await gController.updateReciter(Reciters.reciters[index].id,
                //     quranController.stop, quranController.clearAudios);
              },
            );
          });
          return x;
        });
  }
}
