import 'package:al_huda/Presentation_layer/views/homepage_view/homepage_view.dart';
import 'package:al_huda/util/internationalization/internationalization.dart';
import 'package:al_huda/util/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
git add *
git commit -m  "first commit"
git log --oneline
git push https://github.com/MohammedSolyman/al_huda.git master
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await NotificationService.showPeriodicNotification();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePageView(),
      translations: MyTranlations(),
      fallbackLocale: const Locale('en'),
    );
  }
}
