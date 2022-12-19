import 'package:flutter/material.dart';

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
    final ButtonStyle style = OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      minimumSize: const Size(300.0, 50.0),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 10.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
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
                      height:560.0,
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
                      height: 540.0,
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
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          // color of the shadow
                          color: AppColors.darkGoldenrodMap[50]!,
                          offset: const Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 30.0,
                      height: 2.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: AppColors.darkGoldenrodMap[900]
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  OutlinedButton(
                    style: style,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Ekran główny', style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  OutlinedButton(
                    style: style,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Zaloguj się', style: TextStyle(fontWeight: FontWeight.w500)),
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

