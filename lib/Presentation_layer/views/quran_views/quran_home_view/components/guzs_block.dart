import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/Presentation_layer/controllers/quran_controllers/quran_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuzsBlock extends StatelessWidget {
  const GuzsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    QuranHomeController controller = Get.find<QuranHomeController>();
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(70)),
            color: SkyColor.skyColor.shade500),
        child: Scrollbar(
          interactive: true,
          radius: const Radius.circular(20),
          thickness: 15,
          thumbVisibility: false,
          child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      controller.goToGuz(guzNumber: index + 1);
                    },
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 70,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: SkyColor.skyColor.shade50,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('guz ${index + 1}',
                                style: TextStyle(
                                    fontSize: TextSizes.normal,
                                    color: GreyClolor.greyClolor.shade500)),
                            Text('جزء ${index + 1}',
                                style: TextStyle(
                                    fontSize: TextSizes.normal,
                                    color: GreyClolor.greyClolor.shade500)),
                          ],
                        )));
              }),
        ),
      ),
    );
  }
}
