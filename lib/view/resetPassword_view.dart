import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewModel/auth_viewModel.dart';
import 'components/sectionTitle.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPassFormKey = GlobalKey<FormState>();
  final AuthViewModel _authViewModel = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController resetCodeController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sectionTitle('Resetowanie hasła'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Podaj adres e-mail, powiązany z kontem, dla którego chcesz zresetować hasło. Wyślemy na niego kod resetujący.'),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: ()  {
                        Navigator.pop(context);
                      },
                      child: Text('Anuluj')
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {

                          final message = await _authViewModel.resetPassword(emailController.text.trim());
                          Get.dialog(passwordResetStatusMessage(message));
                        }
                      },
                      child: Text('Wyślij kod')
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  StatefulBuilder passwordResetStatusMessage(dynamic message) {
    String content = '';
    bool closeButton = false;
    if(message['error'] == null) {
      content = message['message'];
    } else {
      content = message['error'];
    }
    return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Resetowanie hasła"),
            content: Text(content),
            actions: message['error'] == null
                ? <Widget>[
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _newPassFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: resetCodeController,
                          decoration: const InputDecoration(
                            labelText: 'Kod resetujący',
                          ),
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Należy podać kod z wiadomości email'
                                : null;
                          },
                        ),
                        TextFormField(
                          controller: newPassController,
                          decoration: const InputDecoration(
                            labelText: 'Nowe hasło',
                          ),
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Należy podać hasło'
                                : null;
                          },
                        ),
                        closeButton ? ElevatedButton(
                          child: const Text('Zamknij'),
                          onPressed: () { Navigator.pop((context));},
                        ) : ElevatedButton(
                          child: const Text('Zmień hasło'),
                          onPressed: () async {
                            if (_newPassFormKey.currentState?.validate() ?? false) {
                              String response = await _authViewModel.changePassword(
                                  resetCodeController.text,
                                  emailController.text.trim(),
                                  newPassController.text
                              );
                              setState(() {
                                content = response;
                                closeButton = true;
                              });
                            }
                          },
                        ),
                      ],
                    )
                  )
                ] : <Widget>[
                  ElevatedButton(
                    child: const Text('Wróć'),
                    onPressed: () { Navigator.pop((context));},
                  ),
                ]
          );
        }
    );
  }
}
