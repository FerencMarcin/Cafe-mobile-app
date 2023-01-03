import 'package:carousel_slider/carousel_slider.dart';
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
      body: SingleChildScrollView(
        child: Container(
          height: 900.0,
          color: AppColors.floralWhite,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper:ImageBorderClip(),
                      child:Container(
                        color: AppColors.burlyWood,
                        height:220.0,
                      ),
                    ),
                    ClipPath(
                      clipper: ImageBorderClip(),
                      child: Container(
                        height: 200.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage("images/unauthHeader.jpg"),
                              colorFilter: ColorFilter.mode(AppColors.photoFilter, BlendMode.modulate),
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
                          CarouselSlider(
                            items: [
                              carouselItem('images/sliderMenu.jpg', 'Menu kawiarnii', '/menu'),
                              carouselItem('images/sliderInfo.jpg', 'O nas', '/aboutUs'),
                              carouselItem('images/sliderLogin.jpg', 'Dołącz do nas!', '/login')
                            ],
                            options: CarouselOptions(
                              height: 350.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                      )
                    ),

                    Container(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Text("Dlaczego warto dołączyć?", style: TextStyle(color: AppColors.darkGoldenrodMap[800], fontSize: 24.0, fontWeight: FontWeight.w600),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" - Możliwość rezerwacji stolika", style: benefitTextStyle),
                          Text(" - Zbieranie punktów lojalnościowych", style: benefitTextStyle),
                          Text(" - Atrakcyjne kupony promocyjne", style: benefitTextStyle),
                          Text(" - Podgląd historii zamówień", style: benefitTextStyle)
                        ],
                      ),
                    ),
                    homePageMenuButton(outlineButtonStyle, '/login', 'Zaloguj się'),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector carouselItem(String photoPath, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 300.0,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(photoPath),
            colorFilter: ColorFilter.mode(AppColors.burlyWood.withOpacity(0.9), BlendMode.modulate),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(label, style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: AppColors.floralWhite),
          ),
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

  final TextStyle benefitTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGoldenrodMap[700]
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

