import 'package:cafe_mobile_app/repository/repository.dart';
import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/AboutUsPage.dart';
import 'package:cafe_mobile_app/view/LoginPage.dart';
import 'package:cafe_mobile_app/view/MenuPage.dart';
import 'package:cafe_mobile_app/view/RegisterPage.dart';
import 'package:cafe_mobile_app/view/authentication/LoginPage.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key, required this.title, required this.userRepository});

  final String title;
  final UserRepository userRepository;

  @override
  State<StartScreen> createState() => _StartScreenState(userRepository: userRepository);
}

class _StartScreenState extends State<StartScreen> {
  final UserRepository userRepository;

  _StartScreenState({Key? key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      minimumSize: const Size(300, 40),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("images/startScreenPhoto.jpg"),
                  colorFilter: ColorFilter.mode(AppColors.dutchWhite.withOpacity(0.4), BlendMode.modulate),
                  fit: BoxFit.cover
                  ),
                ),
              ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 200),
                                child: Text("tu będzie logo", style: TextStyle(fontSize: 20))
                            ),
                            Text("Witaj w aplikacji", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40)),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Moja kawiarnia", style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 40))
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            style: style,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MenuScreen())
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Wyświetl menu', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: style,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage(userRepository: userRepository))
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Zaloguj się', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: style,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegistrationScreen())
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Zarejestruj się', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: style,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AboutUsScreen())
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('O nas', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}