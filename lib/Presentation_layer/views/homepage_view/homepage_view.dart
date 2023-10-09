import 'package:al_huda/Presentation_layer/views/quran_views/quran_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to(() => const QuranHomeView());
              },
              child: const Text('quran')),
          ElevatedButton(onPressed: () {}, child: const Text('prayer')),
          ElevatedButton(onPressed: () {}, child: const Text('athkar')),
          ElevatedButton(onPressed: () {}, child: const Text('lessons'))
        ],
      ),
    );
  }
}
