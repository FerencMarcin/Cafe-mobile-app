import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/concept_LoginPage.dart';
import 'package:flutter/material.dart';

const List<String> sexList = <String>["Mężczyzna", "Kobieta"];

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  String sexSelect = sexList.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Rejestracja'),),
      body: Center(
        child: ListView(
          children: <Widget>[
          const Text("Logo"),
          Form(
             key: _loginFormKey,
             child: Column(
               children: <Widget>[
                 const Padding(
                   padding: EdgeInsets.only(top: 20, bottom: 40),
                   child: Text(
                     "Rejestracja",
                     style: TextStyle(
                       fontSize: 35,
                       fontWeight: FontWeight.w700,
                       color: AppColors.darkGoldenrod,
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                   child: TextFormField(
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Wprowadź adres e-mail';
                       }
                       return null;
                     },
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Adres E-mail',
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                   child: TextFormField(
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Wprowadź numer telefonu';
                       }
                       return null;
                     },
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Numer telefonu',
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                   child: TextFormField(
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Wprowadź hasło';
                       }
                       return null;
                     },
                     obscureText: true,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Hasło',
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                   child: DropdownButton<String>(
                     value: sexSelect,
                     icon: const Icon(Icons.arrow_downward),
                     elevation: 16,
                     style: const TextStyle(color: AppColors.darkGoldenrod),
                     underline: Container(
                       height: 2,
                       color: AppColors.darkGoldenrodMap.shade900,
                     ),
                     onChanged: (String? value) {
                       // This is called when the user selects an item.
                       setState(() {
                         sexSelect = value!;
                       });
                     },
                     isExpanded: true,
                     items: sexList.map<DropdownMenuItem<String>>((String value) {
                       return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value),
                       );
                     }).toList(),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 30),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       ElevatedButton(
                         style: const ButtonStyle(
                           backgroundColor: MaterialStatePropertyAll(AppColors.projectRed),
                           minimumSize: MaterialStatePropertyAll(Size(120,40)),
                         ),
                         onPressed: () {
                           Navigator.pop(context);
                         },
                         child: const Text('Anuluj', style: TextStyle(fontWeight: FontWeight.w800)),
                       ),
                       ElevatedButton(
                         style: const ButtonStyle(
                           backgroundColor: MaterialStatePropertyAll(AppColors.aztecGold),
                           minimumSize: MaterialStatePropertyAll(Size(120,40)),
                         ),
                         onPressed: () {
                           if (_loginFormKey.currentState!.validate()) {
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Rejestracja...')),
                             );
                           }
                         },
                         child: const Text('Zarejestruj', style: TextStyle(fontWeight: FontWeight.w800)),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
            Container(
              padding: const EdgeInsets.only(top:100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 3,right: 5),
                      child: const Text("Masz już konto?"),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen(title: "title"))
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(
                                color: AppColors.darkGoldenrod,
                                width: 1.0,
                              ))
                          ),
                          child: const Text(
                            "Zaloguj się!",
                            style: TextStyle(color: AppColors.projectDarkBlue, fontWeight: FontWeight.bold),
                          ),
                        )
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}