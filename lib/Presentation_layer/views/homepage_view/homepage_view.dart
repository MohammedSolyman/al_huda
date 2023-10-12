import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/Presentation_layer/views/quran_views/quran_home_view.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Get.put(GlobalController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PopupMenuButton(
              icon: const Icon(Icons.language),
              itemBuilder: (BuildContext context) {
                PopupMenuEntry p1 = PopupMenuItem(
                  child: const Text('عربى'),
                  onTap: () {
                    controller.updateMyLocate('ar');
                  },
                );
                PopupMenuEntry p2 = PopupMenuItem(
                  child: const Text('french'),
                  onTap: () {
                    controller.updateMyLocate('fr');
                  },
                );
                PopupMenuEntry p3 = PopupMenuItem(
                  child: const Text('english'),
                  onTap: () {
                    controller.updateMyLocate('en');
                  },
                );
                PopupMenuEntry p4 = PopupMenuItem(
                  child: const Text('spanish'),
                  onTap: () {
                    controller.updateMyLocate('es');
                  },
                );
                List<PopupMenuEntry<dynamic>> x = [p1, p2, p3, p4];
                return x;
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => const QuranHomeView());
                  },
                  child: Text(
                    IntConstants.holyQuran.tr,
                    style: const TextStyle(fontSize: 25),
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(IntConstants.praying.tr,
                      style: const TextStyle(fontSize: 25)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: Text(IntConstants.athkar.tr,
                      style: const TextStyle(fontSize: 25))),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(IntConstants.lessons.tr,
                      style: const TextStyle(fontSize: 25)))
            ],
          )
        ],
      ),
    );
  }
}
