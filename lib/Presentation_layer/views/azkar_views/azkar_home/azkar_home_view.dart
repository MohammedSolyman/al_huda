import 'package:al_huda/Presentation_layer/controllers/azkar_controllers/azkar_home_controller.dart';
import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/zekr_category_view.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AzkarHomeView extends StatelessWidget {
  const AzkarHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return SafeArea(
      child: Scaffold(
          backgroundColor: BlueColor.blueColor.shade500,
          body: const Column(
            children: [
              SizedBox(
                height: 40,
              ),
              AzkarBody()
            ],
          )),
    );
  }
}

class AzkarBody extends StatelessWidget {
  const AzkarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(70)),
            color: SkyColor.skyColor.shade500),
        child: const Scrollbar(
          interactive: true,
          radius: Radius.circular(20),
          thickness: 15,
          thumbVisibility: false,
          child: AzkarList(),
        ),
      ),
    );
  }
}

class AzkarList extends StatelessWidget {
  const AzkarList({super.key});

  @override
  Widget build(BuildContext context) {
    AzkarController controller = Get.put(AzkarController());

    return Obx(() {
      if (controller.model.value.arabicAzkar.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
            itemCount: controller.model.value.languageAzkarCats.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    int catId = controller
                        .model.value.languageAzkarCats[index].categoryId!;

                    controller.getCatAzkar(catId);

                    Get.to(() => const ZekrCategoryView());
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(7),
                    // height: 70,
                    decoration: BoxDecoration(
                        color: SkyColor.skyColor.shade50,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                  fontSize: TextSizes.normal,
                                  color: GreyClolor.greyClolor.shade500),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              color: GreyClolor.greyClolor.shade500,
                              height: 30,
                              width: 3,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: AutoSizeText(
                                  controller.model.value.arabicAzkarCats[index]
                                      .category!,
                                  style: TextStyle(
                                    fontSize: TextSizes.normal,
                                    color: GreyClolor.greyClolor.shade500,
                                  ),
                                  maxLines: 2,
                                  textDirection: TextDirection.rtl,
                                  // textAlign: TextAlign.right,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  controller.model.value
                                      .languageAzkarCats[index].category!,
                                  style: TextStyle(
                                      fontSize: TextSizes.normal,
                                      color: GreyClolor.greyClolor.shade500),
                                  maxLines: 2,
                                  textDirection: TextDirection.ltr,
                                  // textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            });
      }
    });
  }
}
