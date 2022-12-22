import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class NewReservationView extends StatefulWidget {
  const NewReservationView({Key? key}) : super(key: key);

  @override
  State<NewReservationView> createState() => _NewReservationViewState();
}

class _NewReservationViewState extends State<NewReservationView> {
  DateTime nowDate = DateTime.now();
  TimeOfDay nowTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    if(nowTime.hour > 19) {
      nowTime = TimeOfDay(hour: 8, minute: 0);
      nowDate = DateTime(nowDate.year, nowDate.month, nowDate.day+1);
    } else if (nowTime.hour < 8) {
      nowTime = TimeOfDay(hour: 8, minute: 0);
    }
    final hours = nowTime.hour.toString().padLeft(2, '0');
    final minutes = nowTime.minute.toString().padLeft(2, '0');

    return Scaffold(
        appBar: AppBarView(appBarTitle: 'Nowa rezerwacja'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sectionTitle('Dane rezerwacji'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: formContainerDecoration,
                      height: 280.0,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          children: [
                            formLabel('Data:  ', formLabelText, Icons.calendar_month_outlined),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text('${nowDate.year}-${nowDate.month}-${nowDate.day}',
                                      style: subsectionText),
                                ),
                                const Spacer(),
                                OutlinedButton(
                                  style: pickerButtonStyle,
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(context: context,
                                      initialDate: nowDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(nowDate.year, nowDate.month+1, nowDate.day),
                                      builder: (context, child) {
                                        return datePickerTheme(context, child);
                                      }
                                    );
                                    if(newDate == null) return;
                                    String? errorMessage;
                                    if((newDate == nowDate) && (nowTime.hour > 20)){
                                      errorMessage = 'Lokal jest już zamknięty';
                                    }
                                    if(errorMessage != null){
                                      Get.dialog(
                                          AlertDialog(
                                            title: Text('Błędna data'),
                                            content: Text(errorMessage),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: Text("Wróć"),
                                                onPressed: () {
                                                  Get.back();
                                                  return;
                                                },
                                              )
                                            ],
                                          )

                                      );
                                    }
                                    setState(() => nowDate = newDate);
                                },
                                  child: Text('Wybierz date', style: subsectionText))
                              ],
                            ),
                            formLabel('Godzina:  ', formLabelText, Icons.watch_later_outlined),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text('$hours:$minutes',
                                      style: subsectionText),
                                ),
                                const Spacer(),
                                OutlinedButton(
                                    style: pickerButtonStyle,
                                    onPressed: () async {
                                      TimeOfDay? newTime = await showTimePicker(context: context,
                                          initialTime: nowTime,
                                          builder: (context, child) {
                                            return timePickerTheme(context, child);
                                          }
                                      );
                                      if(newTime == null) return;
                                      String? errorMessage;
                                      if((newTime.hour < 8) || (newTime.hour >= 20)){
                                        errorMessage = 'Lokal jest otwart między godziną 8 a 20. Rezerwacje na bieżący dzień składać można do godziny 19:00';
                                      }
                                      if(errorMessage != null){
                                        Get.dialog(
                                            AlertDialog(
                                              title: Text('Błędna data'),
                                              content: Text(errorMessage),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  child: Text("Wróć"),
                                                  onPressed: () {
                                                    Get.back();
                                                    return;
                                                  },
                                                )
                                              ],
                                            )
                                        );
                                      }
                                      setState(() => nowTime = newTime);
                                    },
                                    child: Text('Wybierz godzinę', style: subsectionText))
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: OutlinedButton(
                                style: pickerButtonStyle,
                                onPressed: () {
                                  log('pokaż stoliki clicked');
                                },
                                child: Text('Pokaż dostępne stoliki', style: subsectionText)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  sectionTitle('Dostępne stoliki'),
                  Container(
                    height: 500.0,
                    child: Text('Wybierz datę rezerwacji',
                      style: subsectionText,
                      textAlign: TextAlign.center,
                    )
                  )
                ],
              ),
            ),
          ),
        )

    );
  }

  TextStyle formLabelText = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.darkGoldenrodMap[800]
  );

  TextStyle subsectionText = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGoldenrodMap[700]
  );

  final ButtonStyle pickerButtonStyle = OutlinedButton.styleFrom(
      textStyle: TextStyle(fontSize: 17.0, color: AppColors.darkGoldenrodMap[800]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 5.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );

  BoxDecoration formContainerDecoration = BoxDecoration(
    border: Border.all(color: AppColors.darkGoldenrodMap[100]!, width: 2.0),
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0)
    ),
    color: AppColors.floralWhiteMap[200],
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 2.0,
        blurRadius: 8.0,
        offset: const Offset(1.0, 3.0),
      ),
    ],
  );

  Theme datePickerTheme(BuildContext context, Widget? child) {
    return Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.dutchWhite,
              onPrimary: AppColors.darkGoldenrodMap[900]!,
              onSurface: AppColors.darkGoldenrodMap[800]!,
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkGoldenrodMap[900]
                )
            )
        ),
        child: child!
    );
  }

  Theme timePickerTheme(BuildContext context, Widget? child) {
    return Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.darkGoldenrodMap[600]!,
              onPrimary: AppColors.floralWhite,
              onSurface: AppColors.darkGoldenrodMap[900]!,
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkGoldenrodMap[900]
                )
            )
        ),
        child: child!
    );
  }

  Padding formLabel(String label, TextStyle textStyle, IconData icon, ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(icon, color: AppColors.darkGoldenrodMap[900]),
          ),
          Text(label, style: textStyle),
        ],
      ),
    );
  }
}