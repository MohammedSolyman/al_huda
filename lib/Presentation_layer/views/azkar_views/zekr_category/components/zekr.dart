import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/arabic_zekr.dart';
import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/language_zekr.dart';
import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/zekr_number_and_operations.dart';
import 'package:flutter/material.dart';

class Zekr extends StatelessWidget {
  const Zekr(
      {required this.arabicZekr,
      required this.languageZekr,
      required this.zekrNumber,
      super.key});

  final String arabicZekr;
  final String languageZekr;
  final int zekrNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ZekrNumberAndOperations(zekrNumber: zekrNumber),
          ArabicZekr(arabicZekr: arabicZekr),
          LanguageZekr(languageZekr: languageZekr)
        ],
      ),
    );
  }
}
