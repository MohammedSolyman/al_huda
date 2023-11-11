import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:flutter/material.dart';

class ZekrNumberAndOperations extends StatelessWidget {
  const ZekrNumberAndOperations({
    required this.zekrNumber,
    super.key,
  });

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
          const Row(
            children: [ZekrSharing(), ZekrCopying()],
          )
        ],
      ),
    );
  }
}

class ZekrSharing extends StatelessWidget {
  const ZekrSharing({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {},
        icon: Icon(Icons.share, color: BlueColor.blueColor.shade400));
  }
}

class ZekrCopying extends StatelessWidget {
  const ZekrCopying({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {},
        icon: Icon(Icons.copy, color: BlueColor.blueColor.shade400));
  }
}
