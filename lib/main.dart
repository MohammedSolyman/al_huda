import 'package:al_huda/Presentation_layer/views/homepage_view/homepage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
 git push https://github.com/MohammedSolyman/al_huda.git master
 */
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomePageView(),
    );
  }
}
