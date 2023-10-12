import 'package:al_huda/Presentation_layer/controllers/global_controller.dart';
import 'package:al_huda/data_layer/api_models/guz_model.dart';
import 'package:al_huda/data_layer/api_operations/quran_api_operations.dart';
import 'package:al_huda/data_layer/audio_operations/audio_operations.dart';
import 'package:al_huda/data_layer/view_models/guz_view_model.dart';
import 'package:get/get.dart';

class GuzViewController extends GetxController {
  Rx<GuzViewModel> model = GuzViewModel().obs;
  QuranApiOperations quranApi = QuranApiOperations();
  AudioOperations audioOperations = AudioOperations();
  GlobalController iController = Get.find<GlobalController>();
}
