import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'bloc/cep_bloc.dart';
import 'home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => CepBloc(Dio()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscador de CEP',
      home: QRcode(),
    );
  }
}
