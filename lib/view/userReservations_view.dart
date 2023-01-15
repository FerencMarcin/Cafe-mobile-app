import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/utils/errorAlert_view.dart';
import 'package:cafe_mobile_app/view/utils/loading_view.dart';
import 'package:cafe_mobile_app/viewModel/reservations_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appBar/appBar_view.dart';
import 'components/sectionTitle.dart';

class UserReservationsView extends StatefulWidget {
  const UserReservationsView({Key? key}) : super(key: key);

  @override
  State<UserReservationsView> createState() => _UserReservationsViewState();
}

class _UserReservationsViewState extends State<UserReservationsView> {
  final ReservationsViewModel _reservationsViewModel = Get.put(ReservationsViewModel());
  String _sortType = 'date_desc';
  bool _onlyActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarView(appBarTitle: ''),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sectionTitle('Moje rezerwacje'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text("Sortowanie: ", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    elevation: 1,
                    value: _sortType,
                    items: const [
                      DropdownMenuItem(value: 'date_desc', child: Text('Najnowsze')),
                      DropdownMenuItem(value: 'date_asc', child: Text('Najstarsze')),
                    ],
                    onChanged: (value) {setState(() {_sortType = value!;});},
                  ),
                  const Spacer(),
                  Text('Pokaż aktywne: ', style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                  Switch(
                    inactiveThumbColor: AppColors.darkGoldenrodMap[900],
                    value: _onlyActive,
                    onChanged: (value) {setState(() {_onlyActive = value;});}
                  )
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 600.0,
              child: FutureBuilder(
                future: _reservationsViewModel.getUserReservations(_sortType, _onlyActive),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ErrorAlertView(description: snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return createReservationsListView(context, snapshot);
                  } else {
                    return const LoadingView();
                  }
                },
              ),
            )
          ],
        )
    );
  }

  Widget createReservationsListView(BuildContext context, AsyncSnapshot<List> snapshot) {
    var values = snapshot.data;
    return values == null
      ? const Text("Lista rezerwacji obecnie nie jest dostępne")
      : values.isEmpty
        ? const Text("Nie posiadasz żadnych rezerwacji")
        :  ListView.builder(
            itemCount: values.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,

            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: values[index].ReservationStatusId == 1 
                          ? const Icon(Icons.chair_outlined, size: 30.0, color: AppColors.projectGreen)
                          : const Icon(Icons.chair_rounded, size: 30.0, color: AppColors.aztecGold),
                      title: Text('Data: ${values[index].date}', style: tileTitleStyle),
                      subtitle: Row(
                        children: [
                          Text('Stolik: ${values[index].TableId}, Status:  '),
                          values[index].ReservationStatusId == 1
                              ? const Text("Aktywna", style: TextStyle(color: AppColors.projectGreen))
                              : const Text("Zakończona", style: TextStyle(color: AppColors.darkGoldenrod))
                        ],
                      ),
                      trailing: values[index].ReservationStatusId == 1
                          ? OutlinedButton(
                            style:cancelButtonStyle,
                            onPressed: () {
                              Get.dialog(confirmCancelation(values[index].date, values[index].TableId, values[index].id));
                            },
                            child: Text("Anuluj", style: TextStyle(color: AppColors.darkGoldenrodMap[800])),
                          )
                          : const SizedBox(width: 0.0),
                    ),
                    const Divider()
                  ],
                )
              );
            }
        );
  }

  StatefulBuilder confirmCancelation(String reservationDate, int tableNumber, int reservationId) {
    String content = "Czy chcesz anulować rezerwację stolika nr: $tableNumber, na $reservationDate";
    bool confirmButton = true;
    return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Nowa Rezerwacja"),
            content: Text(content),
            actions: confirmButton ? <Widget>[
              ElevatedButton(
                child: const Text('Anuluj'),
                onPressed: () {
                  Navigator.pop((context));
                },
              ),
              ElevatedButton(
                child: const Text('Potwierdź'),
                onPressed: () async {
                  String response = await _reservationsViewModel
                      .cancelReservations(reservationId);
                  setState(() {
                    content = response;
                    confirmButton = false;
                  });
                },
              )
            ] : <Widget>[
              ElevatedButton(
                child: const Text('Zamknij'),
                onPressed: () {
                  Navigator.pop((context));
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ],
          );
        }
    );
  }

  final TextStyle tileTitleStyle = TextStyle(
    color: AppColors.darkGoldenrodMap[900],
    fontWeight: FontWeight.bold
  );

  final ButtonStyle cancelButtonStyle = OutlinedButton.styleFrom(
      textStyle: TextStyle(fontSize: 17.0, color: AppColors.darkGoldenrodMap[800]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(width: 2.0, color: AppColors.aztecGold),
      backgroundColor: AppColors.darkGoldenrodMap[50],
      elevation: 5.0,
      shadowColor: AppColors.darkGoldenrodMap[100]
  );
}