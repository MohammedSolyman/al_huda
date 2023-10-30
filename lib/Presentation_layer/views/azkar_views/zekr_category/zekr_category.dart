import 'package:al_huda/data_layer/json_models/azkar_model.dart';
import 'package:al_huda/util/constants/colors_consts.dart';
import 'package:al_huda/util/constants/paths_consts.dart';
import 'package:flutter/material.dart';

class ZekrCategory extends StatelessWidget {
  const ZekrCategory(
      {required this.langCatAzkar, required this.arabCatAzkar, super.key});

  final List<Azkar> langCatAzkar;
  final List<Azkar> arabCatAzkar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SkyColor.skyColor.shade500,
        body: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: BlueColor.blueColor.shade900,
                      width: 4,
                    ),
                    gradient: LinearGradient(colors: [
                      SeaColor.seaColorAccents.shade100,
                      SeaColor.seaColorAccents.shade200,
                      SeaColor.seaColorAccents.shade400,
                      SeaColor.seaColorAccents.shade700,
                    ]),
                    boxShadow: [
                      BoxShadow(
                          color: BlueColor.blueColor.shade900,
                          blurRadius: 5,
                          offset: const Offset(1, 1))
                    ]),
                child: const Column(
                  children: [Text('arabic cat'), Text('lan cat')],
                ),
              ),
              Expanded(
                child: Scrollbar(
                  interactive: true,
                  radius: const Radius.circular(20),
                  thickness: 15,
                  thumbVisibility: false,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04),
                      child: Column(
                        children: List.generate(langCatAzkar.length, (index) {
                          String arabicZekr = arabCatAzkar[index].zekarText!;
                          String languageZekr = langCatAzkar[index].zekarText!;
                          return Zekr(
                            arabicZekr: arabicZekr,
                            languageZekr: languageZekr,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          //  const MyGradient(),
        ]),
      ),
    );
  }
}

class Zekr extends StatelessWidget {
  const Zekr({required this.arabicZekr, required this.languageZekr, super.key});

  final String arabicZekr;
  final String languageZekr;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const ZekrNumberAndOperations(),
          ArabicZekr(arabicZekr: arabicZekr),
          LanguageZekr(languageZekr: languageZekr)
        ],
      ),
    );
  }
}

class ArabicZekr extends StatelessWidget {
  const ArabicZekr({
    required this.arabicZekr,
    super.key,
  });

  final String arabicZekr;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(arabicZekr),
    );
  }
}

class ZekrNumberAndOperations extends StatelessWidget {
  const ZekrNumberAndOperations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: SkyColor.skyColor.shade50,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AyahsPaths.ayah4))),
            child: Center(
              child: Text(
                'zekr',
                style: TextStyle(
                    fontSize: TextSizes.medium,
                    color: BlueColor.blueColor.shade400),
              ),
            ),
          ),
          const Row(
            children: [
              Icon(Icons.share),
              Icon(Icons.copy),
            ],
          )
        ],
      ),
    );
  }
}

class LanguageZekr extends StatelessWidget {
  const LanguageZekr({
    required this.languageZekr,
    super.key,
  });

  final String languageZekr;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(languageZekr),
    );
  }
}