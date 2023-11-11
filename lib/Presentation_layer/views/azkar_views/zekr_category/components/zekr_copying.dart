import 'package:al_huda/Presentation_layer/controllers/azkar_controllers/azkar_home_controller.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/internationlization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ZekrCopying extends StatelessWidget {
  const ZekrCopying(
      {required this.arabicZekr, required this.languageZekr, super.key});

  final String arabicZekr;
  final String languageZekr;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await copyZekrToClipbaord(arabicZekr, languageZekr);
        },
        icon: Icon(Icons.copy, color: BlueColor.blueColor.shade400));
  }
}

Future<void> copyZekrToClipbaord(String arabicZekr, String languageZekr) async {
  AzkarController controller = Get.find<AzkarController>();

  String arabicZekrCategory = controller.model.value.arabicSelectedCategory;
  String languageZekrCategory = controller.model.value.languageSelectedCategory;

  await Clipboard.setData(ClipboardData(text: """  
${IntConstants.fromAlHudaapplication.tr}:

$arabicZekrCategory
$languageZekrCategory
  
$arabicZekr
$languageZekr
"""));

  GetSnackBar snackbar = const GetSnackBar(
    message: 'zekr was coppied',
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(snackbar);
}
