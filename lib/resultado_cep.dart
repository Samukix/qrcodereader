import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cep_bloc.dart';
import 'bloc/cep_state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirmar QR Code', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), backgroundColor: Colors.red),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<CepBloc, CepState>(
          builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CEP:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Text('Logradouro:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Text('Bairro:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Text('Cidade:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      Text('UF:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                    ],
              )]);
          },
        ),
      ),
    );
  }
}
