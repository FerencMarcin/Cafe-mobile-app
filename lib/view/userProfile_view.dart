import 'dart:developer';

import 'package:cafe_mobile_app/view/utils/errorAlert_view.dart';
import 'package:cafe_mobile_app/view/utils/loading_view.dart';
import 'package:cafe_mobile_app/view/utils/logoutAlert_view.dart';
import 'package:cafe_mobile_app/viewModel/user_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import '../viewModel/auth_viewModel.dart';
import 'appBar/appBar_view.dart';
import 'components/authForm.dart';
import 'components/sectionTitle.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final UserViewModel _userViewModel = Get.put(UserViewModel());
  final _editFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Mój profil'),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Icon(Icons.account_circle_outlined, size: 120.0, color: AppColors.darkGoldenrodMap[800]),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      color: AppColors.dutchWhite.withOpacity(0.6),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  height: 600.0,
                  child: FutureBuilder(
                    future: _userViewModel.getUserData(),
                    initialData: const [],
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        if(snapshot.error == 403){
                          return const LogoutAlertView();
                        } else {
                          return ErrorAlertView(description: snapshot.error.toString());
                        }
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return createUserDataView(context, snapshot);
                      } else {
                        return const LoadingView();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget createUserDataView(BuildContext context, AsyncSnapshot snapshot) {
    var user = snapshot.data;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    emailController.text = user.email;
    numberController.text = user.phone;
    return user == null ? const Text("Profil aktualnie nie jest dostępny")
    : Column(
        children: [
          const SizedBox(height: 20.0),
          userDataLabel('Imie', firstNameController, AuthForm.firstNameFormField(firstNameController), user.sex),
          userData(user.firstName),
          userDataLabel('Nazwisko', lastNameController, AuthForm.lastNameFormField(lastNameController), user.sex),
          userData(user.lastName),
          userDataLabel('E-mail', emailController, AuthForm.emailFormField(emailController), user.sex),
          userData(user.email),
          userDataLabel('Numer telefonu', numberController, AuthForm.phoneNumberFormField(numberController), user.sex),
          userData(user.phone),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Row(
              children: [
                Text('Płeć: ${user.sex}', style: profileDataLabel),
                const Spacer(),

              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Divider(color: AppColors.darkGoldenrod, thickness: 2.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Row(
              children: [
                Text('Twoje punkty: ${user.points.toString()}', style: profileDataLabel),
                const Spacer(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Divider(color: AppColors.darkGoldenrod, thickness: 2.0),
          ),
          ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Get.dialog(changePasswordDialog());
              },
              child: Text('Zmień hasło', style: buttonTextStyle)
          )
        ],
      );
  }

  StatefulBuilder editDialog(String editing, TextEditingController controller, TextFormField inputField, String sex) {
    String content = 'Edytujesz: $editing';
    bool closeButton = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
            title: Center(child: sectionTitle("Edycja profilu")),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(content, textAlign: TextAlign.justify, style: textStyle),
            ),
            actions: <Widget>[
              Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _editFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
                        child: inputField
                      ),
                      closeButton ? ElevatedButton(
                        style: buttonStyle,
                        child: Text('Zamknij', style: buttonTextStyle,),
                        onPressed: () {
                          Navigator.pop((context));
                          Navigator.pushNamed(context, '/start');
                        },
                      ) : ElevatedButton(
                        style: buttonStyle,
                        child: Text('Zmień $editing', style: buttonTextStyle,),
                        onPressed: () async {
                          if (_editFormKey.currentState?.validate() ?? false) {
                            try {
                              final response = await _userViewModel.updateUserData(
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailController.text.trim(),
                                  numberController.text,
                                  sex
                              );
                              log(response.toString());
                              setState(() {
                                content = response;
                                closeButton = true;
                              });
                              if(editing == 'E-mail') {
                                log('Konieczne będzie ponowne logowanie');
                                Get.defaultDialog(
                                    title: 'Zaloguj się ponownie',
                                    middleText: 'Po zmianie adres e-mail konieczne będzie ponowne zalogowanie do aplikacji',
                                    textConfirm: 'Zaloguj',
                                    onConfirm: () {
                                      final AuthViewModel _authViewModel = Get.find();
                                      _authViewModel.userLogout();
                                      Get.back();
                                    }
                                );
                              }
                            } catch (exception) {
                              setState(() {
                                content = '$exception';
                              });

                            }

                          }
                        },
                      ),
                    ],
                  )
              )
            ]
        );
      }
    );
  }

  StatefulBuilder changePasswordDialog() {
    String content = 'Wprowadź swoje obecne oraz nowe hasło';
    bool closeButton = false;
    return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
              title: Center(child: sectionTitle("Edycja profilu")),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(content, textAlign: TextAlign.justify, style: textStyle),
              ),
              actions: <Widget>[
                Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _editFormKey,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
                            child: AuthForm.passwordFormField(passController, 'Obecne hasło')
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
                            child: AuthForm.passwordFormFieldValidated(newPassController, 'Nowe hasło')
                        ),
                        closeButton ? ElevatedButton(
                          style: buttonStyle,
                          child: Text('Zamknij', style: buttonTextStyle,),
                          onPressed: () {
                            Navigator.pop((context));
                            Navigator.pushNamed(context, '/start');
                          },
                        ) : ElevatedButton(
                          style: buttonStyle,
                          child: Text('Zmień hasło', style: buttonTextStyle,),
                          onPressed: () async {
                            if (_editFormKey.currentState?.validate() ?? false) {
                              try {
                                final response = await _userViewModel.changePassword(
                                  passController.text,
                                  newPassController.text
                                );
                                log(response.toString());
                                setState(() {
                                  content = response;
                                  closeButton = true;
                                });
                              } catch (exception) {
                                setState(() {
                                  content = '$exception';
                                });
                              }
                            }
                          },
                        ),
                      ],
                    )
                )
              ]
          );
        }
    );
  }

  Padding userDataLabel(String label, TextEditingController controller, TextFormField inputField, String sex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: [
          Text('$label:', style: profileDataLabel),
          const Spacer(),
          OutlinedButton(
              style: detailsButtonStyle,
              onPressed: () {
                Get.dialog(editDialog(label, controller, inputField, sex));
              },
              child: Icon(Icons.edit_outlined, color: AppColors.darkGoldenrodMap[800], size: 25.0)
          ),
        ],
      ),
    );
  }

  Row userData(String value) {
    return Row(
      children: [
        Expanded(child: Container(
          height: 40.0,
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
          decoration: const BoxDecoration(
              color: AppColors.floralWhite,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(value, textAlign: TextAlign.center, style: profileDataText),
              const Spacer(),
            ],
          ),
        )),
      ],
    );
  }

  final TextStyle profileDataLabel = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.darkGoldenrodMap[600],
    fontSize: 21.0
  );

  final TextStyle profileDataText = TextStyle(
      fontWeight: FontWeight.w700,
      color: AppColors.darkGoldenrodMap[800],
      fontSize: 19.0
  );

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

  final ButtonStyle detailsButtonStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: BorderSide(width: 2.0, color: AppColors.aztecGold.withOpacity(0.4)),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 4.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );
}
