import 'package:flutter/material.dart';

class MyGradient extends StatelessWidget {
  const MyGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.06,
        left: 0,
        child: Container(
          //    height: MediaQuery.of(context).size.height,
          height: 75,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 235, 240, 255),
                Color.fromARGB(240, 235, 240, 255),
                Color.fromARGB(220, 235, 240, 255),
                Color.fromARGB(150, 235, 240, 255),
                Color.fromARGB(50, 235, 240, 255),
                Color.fromARGB(0, 235, 240, 255),
              ])),
        ));
  }
}
