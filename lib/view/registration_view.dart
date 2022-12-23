import 'package:cafe_mobile_app/viewModel/registration_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'appBar/appBar_view.dart';

const List<String> sexList = <String>["Mężczyzna", "Kobieta"];

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final RegistrationViewModel _registrationViewModel = Get.put(RegistrationViewModel());

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String selectedSex = sexList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Adres email',
                ),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Należy podać adres email'
                      : null;
                },
              ),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Imie',
                ),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Należy podać imie'
                      : null;
                },
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Nazwisko',
                ),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Należy podać nazwisko'
                      : null;
                },
              ),
              TextFormField(
                controller: numberController,
                decoration: const InputDecoration(
                  labelText: 'Numer telefonu',
                ),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Należy podać numer telefonu'
                      : null;
                },
              ),
              TextFormField(
                controller: passController,
                decoration: const InputDecoration(
                  labelText: 'Hasło',
                ),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Należy podać hasło'
                      : null;
                },
              ),
              DropdownButton<String>(
                value: selectedSex,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: AppColors.darkGoldenrod),
                underline: Container(
                  height: 2,
                  color: AppColors.darkGoldenrodMap.shade900,
                ),
                onChanged: (String? newValue) {
                  setState(() => selectedSex = newValue!);
                },
                isExpanded: true,
                items: sexList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: ()  {
                        Navigator.pop(context);
                      },
                      child: Text('Anuluj')
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await _registrationViewModel.userRegistration(
                              emailController.text.trim(),
                              passController.text,
                              firstNameController.text,
                              lastNameController.text,
                              numberController.text,
                              selectedSex);
                        }
                      },
                      child: const Text('Zarejestruj')
                  )
                ],
              ),

              TextButton(
                  onPressed: () async {
                    if(Get.previousRoute == '/login') {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamed(context, '/login');
                    }
                  },
                  child: const Text('Zaloguj się')
              )
            ],
          ),
        ),
      ),
    );
  }
}
