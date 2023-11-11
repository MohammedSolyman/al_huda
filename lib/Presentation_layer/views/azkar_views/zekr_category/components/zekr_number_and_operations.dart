import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/zekr_copying.dart';
import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/zekr_sharing.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';

class ZekrNumberAndOperations extends StatelessWidget {
  const ZekrNumberAndOperations({
    required this.arabicZekr,
    required this.languageZekr,
    required this.zekrNumber,
    super.key,
  });

  final String arabicZekr;
  final String languageZekr;

  final int zekrNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: SkyColor.skyColor.shade50,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              zekrNumber.toString(),
              style: TextStyle(
                  fontSize: TextSizes.medium,
                  color: BlueColor.blueColor.shade400),
            ),
          ),
          Row(
            children: [
              ZekrSharing(
                arabicZekr: arabicZekr,
                languageZekr: languageZekr,
              ),
              ZekrCopying(
                arabicZekr: arabicZekr,
                languageZekr: languageZekr,
              )
            ],
          )
        ],
      ),
    );
  }
}
