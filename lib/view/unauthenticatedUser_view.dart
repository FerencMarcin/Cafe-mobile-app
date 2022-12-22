import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'clipper/imageBorderClip.dart';

class UnauthenticatedUserView extends StatefulWidget {
  const UnauthenticatedUserView({Key? key}) : super(key: key);

  @override
  State<UnauthenticatedUserView> createState() => _UnauthenticatedUserViewState();
}

class _UnauthenticatedUserViewState extends State<UnauthenticatedUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.floralWhite,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  ClipPath(
                    clipper:ImageBorderClip(), //set our custom wave clipper
                    child:Container(
                      color: AppColors.burlyWood,
                      height:220.0,
                    ),
                  ),
                  ClipPath(
                    clipper: ImageBorderClip(),
                    child: Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: const AssetImage("images/unauthHeader.jpg"),
                            colorFilter: ColorFilter.mode(AppColors.floralWhite.withOpacity(0.6), BlendMode.modulate),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: homePageMenuButton(outlineButtonStyle, '/login', 'Ekran główny'),
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
      child: Padding(padding: EdgeInsets.all(10.0),
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

