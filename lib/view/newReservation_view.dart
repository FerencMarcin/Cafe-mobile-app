import 'dart:developer';

import 'package:cafe_mobile_app/viewModel/reservations_viewModel.dart';
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
  String _selectedDate = "";

  @override
  Widget build(BuildContext context) {
    final ReservationsViewModel _reservationsViewModel = Get.put(ReservationsViewModel());
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
                                  setState(() {
                                    _selectedDate = '${nowDate.year}-${nowDate.month}-${nowDate.day}';
                                  });

                                  log(_selectedDate);
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: _selectedDate != "" ? formContainerDecoration : null,
                      height: 300.0,
                      child: _selectedDate != "" ? FutureBuilder(
                        future: _reservationsViewModel.getReservations(_selectedDate),
                        initialData: const [],
                        builder: (context, snapshot) {
                          log('buillder');
                          if (snapshot.hasError) {
                            log(snapshot.error.toString());
                            log('error mes');
                            //TODO show erro view
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            return createTablesGrid(context, snapshot);
                          } else {
                            log('waiting');
                            //TODO LOADING VIEW
                            return const CircularProgressIndicator();
                          }
                        },
                        )
                        : Text('Wybierz datę rezerwacji',
                          style: subsectionText,
                          textAlign: TextAlign.center,
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget createTablesGrid(BuildContext context, AsyncSnapshot<List> snapshot) {

    var values = snapshot.data;
    return values == null ? const Text("Lista stolików obecnie nie jest dostępne")
        :GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0),
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: values[index].TableStatusId == 1
                ? () => Get.dialog(confirmReservation(_selectedDate, values[index].number))
                : null,
              child: Container(
                decoration: formContainerDecoration,
                  child: Column(
                    children: [
                      values[index].TableStatusId == 2
                        ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.table_restaurant_outlined, size: 55.0,
                                color: AppColors.darkGoldenrodMap[100]),
                            Text("Niedostępny", style: tableLabelText)
                          ],)
                        : Icon(Icons.table_restaurant_outlined, size: 55.0,
                          color: AppColors.darkGoldenrodMap[800]),
                      Text('Nr: ${values[index].number}',
                          style: values[index].TableStatusId == 2
                              ? unavailableTableLabelText
                              : tableLabelText),
                      Text('Miejsca: ${values[index].numberOfSeats}',
                          style: values[index].TableStatusId == 2
                              ? unavailableTableLabelText
                              : tableSublabelText)
                    ],
                  ),
              ),
            ),
          );
        }
    );
  }

  StatefulBuilder confirmReservation(String selectedDateTime, int tableNumber) {
    String content = " text";
    bool confirmButton = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Tytul"),
          content: Text(content),
          actions: confirmButton ? <Widget>[
            ElevatedButton(
              child: Text('Anuluj'),
              onPressed: () { Navigator.pop((context));},
            ),
            ElevatedButton(
              child: Text('Potwierdz'),
              onPressed: () async {
                final ReservationsViewModel _reservationsViewModel = Get.find();
                String response = await _reservationsViewModel.createReservations(_selectedDate, tableNumber);
                if(response != null) {
                  setState(() {
                    content = response;
                    confirmButton = false;
                  });
                }
              },
            )
          ] : <Widget> [
            ElevatedButton(
              child: Text('Zamknij'),
              onPressed: () {
                Navigator.pop((context));
                Navigator.pushReplacementNamed(context, '/home');
                setState(() {
                  _selectedDate = '${2022}-${12}-${24}';
                });
              },
            ),
          ],
        );
      }
    );
  }

  AlertDialog confirmReservationDialog(String selectedDateTime, int tableNumber) {
    return AlertDialog(
      title: Text('Błędna data'),
      content: Text("content"),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Wróć"),
          onPressed: () {
            Get.back();
            return;
          },
        ),
        ElevatedButton(
          child: Text("Potwierdź"),
          onPressed: () {
            final ReservationsViewModel _reservationsViewModel = Get.find();
            Future<String> response = _reservationsViewModel.createReservations(_selectedDate, tableNumber);


            // FutureBuilder(
            //   future: _reservationsViewModel.createReservations(_selectedDate, tableNumber),
            //   initialData: const [],
            //   builder: (context, snapshot) {
            //     log('buillderalert');
            //     if (snapshot.hasError) {
            //       log(snapshot.error.toString());
            //       log('error mes');
            //       //TODO show erro view
            //     }
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return Text("aaaaaaaaa2234");
            //     } else {
            //       log('waiting');
            //       //TODO LOADING VIEW
            //       return const CircularProgressIndicator();
            //     }
            //   },
            // );
            //Get.back();
            return;
          },
        )

      ],
    );
  }



  TextStyle tableSublabelText = TextStyle(
      fontSize: 15.0,
      color: AppColors.darkGoldenrodMap[800]
  );

  TextStyle tableLabelText = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: AppColors.darkGoldenrodMap[900]
  );

  TextStyle unavailableTableLabelText = TextStyle(
      fontSize: 16.0,
      color: AppColors.darkGoldenrodMap[100]
  );

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