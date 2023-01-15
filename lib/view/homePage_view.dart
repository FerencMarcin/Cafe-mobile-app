import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'appBar/appBar_view.dart';
import 'clipper/imageBorderClip.dart';
import 'components/sectionTitle.dart';
import 'navigation/navigationDrawer_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBarView(appBarTitle: 'Strona główna'),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: ImageBorderClip(), //set our custom wave clipper
                    child: Container(
                      color: AppColors.burlyWood,
                      height: 200.0,
                    ),
                  ),
                  ClipPath(
                    clipper: ImageBorderClip(),
                    child: Container(
                      height: 190.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: AssetImage("images/initPageImage.jpg"),
                            colorFilter: ColorFilter.mode(
                                AppColors.photoFilter, BlendMode.modulate),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          Text('Witaj! Czego dzisiaj się napijesz?',
                              style: titleTextStyle),
                          const Spacer()
                        ],
                      )),
                ],
              ),
              SizedBox(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      listItem("images/coffeeIcon1.jpg"),
                      listItem("images/coffeeIcon2.jpg"),
                      listItem("images/coffeeIcon3.jpg"),
                      listItem("images/coffeeIcon4.jpg"),
                      listItem("images/coffeeIcon5.jpg"),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: AppColors.aztecGold, width: 5.0)
                      )
                  ),
                  child: sectionTitle('Zobacz co dla Ciebie mamy:'),
                ),
              ),
              SizedBox(
                  height: 500.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: CarouselSlider(
                            items: [
                              carouselItem(
                                  'images/mainPage1.jpg',
                                  'Menu kawiarnii',
                                  '/menu',
                                  Icons.coffee_outlined),
                              carouselItem('images/mainPage5.jpg', 'O nas',
                                  '/aboutUs', Icons.coffee_maker_outlined),
                              carouselItem(
                                  'images/mainPage4.jpg',
                                  'Oferty specjalne!',
                                  '/vouchers',
                                  Icons.price_check_outlined),
                              carouselItem(
                                  'images/mainPage3.jpg',
                                  'Planujesz wizytę?',
                                  '/newReservation',
                                  Icons.calendar_month_outlined),
                              carouselItem(
                                  'images/mainPage2.jpg',
                                  'Twoja historia',
                                  '/userOrders',
                                  Icons.history_outlined)
                            ],
                            options: CarouselOptions(
                              height: 450.0,
                              viewportFraction: 0.9,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                            )),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector carouselItem(
      String photoPath, String label, String route, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 400.0,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(photoPath),
            colorFilter: const ColorFilter.mode(
                AppColors.photoFilter, BlendMode.modulate),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Icon(icon,
                    size: 200.0, color: AppColors.aztecGold.withOpacity(0.3)),
              ),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.floralWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding listItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/menu');
        },
        child: Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }

  OutlinedButton homePageMenuButton(
      ButtonStyle style, String path, String label) {
    return OutlinedButton(
      style: style,
      onPressed: () {
        Navigator.pushNamed(context, path);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label,
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGoldenrodMap[800])),
      ),
    );
  }

  final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      minimumSize: const Size(300.0, 50.0),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 10.0,
      shadowColor: AppColors.darkGoldenrodMap[100]);

  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w800,
      color: AppColors.floralWhite);

  final TextStyle benefitTextStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: AppColors.darkGoldenrodMap[700]);
}
