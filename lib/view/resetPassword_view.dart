import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import '../viewModel/auth_viewModel.dart';
import 'clipper/imageBorderClip.dart';
import 'components/sectionTitle.dart';
import 'components/authForm.dart';

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
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: ImageBorderClip(), //set our custom wave clipper
                    child:Container(
                      color: AppColors.burlyWood,
                      height: 300.0,
                    ),
                  ),
                  ClipPath(
                    clipper: ImageBorderClip(),
                    child: Container(
                      height: 280.0,
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: sectionTitle('Resetowanie hasła')
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text('Podaj adres e-mail, powiązany z kontem, dla którego chcesz zresetować hasło. Wyślemy na niego kod resetujący.', style: textStyle),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 25.0),
                child: AuthForm.emailFormField(emailController),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: ()  {
                      Navigator.pop(context);
                    },
                    child: Text('Anuluj', style: buttonTextStyle)
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {

                        final message = await _authViewModel.resetPassword(emailController.text.trim());
                        Get.dialog(passwordResetStatusMessage(message));
                      }
                    },
                    child: Text('Wyślij kod', style: buttonTextStyle)
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
            title: Center(child: sectionTitle("Resetowanie hasła")),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(content, textAlign: TextAlign.justify, style: textStyle),
            ),
            actions: message['error'] == null
                ? <Widget>[
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _newPassFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                          child: TextFormField(
                            controller: resetCodeController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Kod resetujący',
                              labelStyle: TextStyle(
                                  color: AppColors.darkGoldenrodMap[800]
                              ),
                              prefixIcon: Icon(Icons.wifi_protected_setup_outlined, color: AppColors.darkGoldenrodMap[400]),
                            ),
                            validator: (value) {
                              return (value == null || value.isEmpty)
                                  ? 'Należy podać kod z wiadomości email'
                                  : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
                          child: AuthForm.passwordFormFieldValidated(newPassController),
                        ),
                        closeButton ? ElevatedButton(
                          style: buttonStyle,
                          child: Text('Zamknij', style: buttonTextStyle,),
                          onPressed: () {
                            resetCodeController.clear();
                            newPassController.clear();
                            Navigator.pop((context));
                          },
                        ) : ElevatedButton(
                          style: buttonStyle,
                          child: Text('Zmień hasło', style: buttonTextStyle,),
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
                    style: buttonStyle,
                    child: Text('Wróć', style: buttonTextStyle,),
                    onPressed: () { Navigator.pop((context));},
                  ),
                ]
          );
        }
    );
  }

  final TextStyle textStyle = TextStyle(
      color: AppColors.darkGoldenrodMap[900],
      fontSize: 17.0
  );

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(100.0, 40.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 5.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );

  final TextStyle buttonTextStyle = TextStyle(
      color: AppColors.darkGoldenrodMap[900],
      fontWeight: FontWeight.bold,
      fontSize: 17.0
  );
}
