import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/zekr_body.dart';
import 'package:al_huda/Presentation_layer/views/azkar_views/zekr_category/components/zekr_category_title.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';

class ZekrCategoryView extends StatelessWidget {
  const ZekrCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SkyColor.skyColor.shade500,
        body: const Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [ZekrCategoryTitle(), ZekrBody()],
            ),
          ),
          //  const MyGradient(),
        ]),
      ),
    );
  }
}
