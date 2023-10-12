import 'package:al_huda/data_layer/view_models/quran_home_model.dart';
import 'package:flutter/material.dart';

class GuzView extends StatelessWidget {
  const GuzView({required this.currentGuzMapping, super.key});

  final List<GuzMapping> currentGuzMapping;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
              itemCount: currentGuzMapping.length,
              itemBuilder: (BuildContext context, int chapterIndex) {
                return Column(
                  children: [
                    Container(
                      color: Colors.black,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'f name',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            'arabic name',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: List.generate(40, (ayahIndex) {
                        return Text('     ayah: ${ayahIndex + 1}');
                      }),
                    ),
                  ],
                );
              })),
    );
  }
}
