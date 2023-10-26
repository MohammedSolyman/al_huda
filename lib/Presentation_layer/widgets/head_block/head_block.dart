import 'package:al_huda/Presentation_layer/widgets/head_block/basmala_black/basmala_block.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block/info_block/info_block.dart';
import 'package:al_huda/Presentation_layer/widgets/head_block/name_block/name_block.dart';
import 'package:flutter/material.dart';

class HeadBlock extends StatelessWidget {
  //this includes arabic and language chapter's names.
  //under this head, the all MyAyahs of chapter will be listed (in case of chapter
  // view),or some of MyAyahs of this chapter will be listed (in case of juz view).
  //this includes also audio controllers which plays the list of MyAyahs under
  //this head.

  HeadBlock({this.guzNumber, required this.headIndex, super.key});

  final int headIndex;
  int? guzNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameBlock(headIndex: headIndex, guzNumber: guzNumber),
        InfoBlock(headIndex: headIndex),
        BasmalaBlock(headIndex: headIndex)
      ],
    );
  }
}
