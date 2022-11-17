import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.snapshot}) : super(key: key);
  final AsyncSnapshot<Object?> snapshot;

  @override
  Widget build(BuildContext context, ) => Scaffold(
    body: Center(
      //TODO create better error view
      child: Text('Błąd: ${snapshot.error}'),
    ),
  );
}
