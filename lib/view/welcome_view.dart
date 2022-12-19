import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'clipper/imageBorderClip.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      minimumSize: const Size(300, 40),
    );

    return Scaffold(
      body: Container(
        color: AppColors.floralWhite,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  ClipPath(
                    clipper:imageBorderClip(), //set our custom wave clipper
                    child:Container(
                      color: AppColors.aztecGold,
                      height:560,
                    ),
                  ),
                  // Opacity(
                  //   opacity: 0.8,
                  //   child: ClipPath(
                  //     clipper:imageBorderClip(), //set our custom wave clipper
                  //     child:Container(
                  //       color: AppColors.aztecGold,
                  //       height:560,
                  //     ),
                  //   ),
                  // ),
                  ClipPath(
                    clipper: imageBorderClip(),
                    child: Container(
                      height: 540,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: const AssetImage("images/initPageImage.jpg"),
                            colorFilter: ColorFilter.mode(AppColors.burlyWood.withOpacity(0.8), BlendMode.modulate),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Witaj w Twojej kawiarni",
                    style: TextStyle(
                      fontSize: 28,
                      height: 2,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: AppColors.darkGoldenrodMap[900]
                    ),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Ekran główny', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Zaloguj się', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

