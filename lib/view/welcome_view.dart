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
                    clipper:ImageBorderClip(), //set our custom wave clipper
                    child:Container(
                      color: AppColors.burlyWood,
                      height: 560.0,
                    ),
                  ),
                  ClipPath(
                    clipper: ImageBorderClip(),
                    child: Container(
                      height: 540.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: AssetImage("images/initPageImage.jpg"),
                            colorFilter: ColorFilter.mode(AppColors.photoFilter, BlendMode.modulate),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 250.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                              //colorFilter: ColorFilter.mode(AppColors.photoFilter, BlendMode.modulate),
                              fit: BoxFit.fitHeight
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100.0,
                      )
                    ]
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Witaj w Twojej kawiarni",
                    style: titleTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: homePageMenuButton(outlineButtonStyle, '/unauthenticated', 'Ekran główny'),
                  ),
                  homePageMenuButton(outlineButtonStyle, '/login', 'Zaloguj się'),
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      minimumSize: const Size(300.0, 50.0),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 10.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );

  final TextStyle titleTextStyle = TextStyle(
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: AppColors.darkGoldenrodMap[50]!,
        offset: const Offset(5.0, 5.0),
      ),
    ],
    fontSize: 30.0,
    height: 2.0,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: AppColors.darkGoldenrodMap[900]
  );

  OutlinedButton homePageMenuButton(ButtonStyle style, String path, String label) {
    return OutlinedButton(
      style: style,
      onPressed: () {Navigator.pushNamed(context, path);},
      child: Padding(padding: const EdgeInsets.all(10.0),
        child: Text(label,
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGoldenrodMap[800])
        ),
      ),
    );
  }
}

