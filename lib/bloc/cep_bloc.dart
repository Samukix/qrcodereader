import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'cep_event.dart';
import 'cep_state.dart';

class CepBloc extends Bloc<CepEvent, CepState> {
  final Dio dio;

  CepBloc(this.dio) : super(CepInitial()) {
    on<GetCep>(_onGetCep);
  }

  Future<void> _onGetCep(GetCep event, Emitter<CepState> emit) async {
    emit(CepLoading());
    try {
  final response = await dio.get('https://viacep.com.br/ws/${event.cep}/json/');

  final data = response.data;

  final filteredData = {
    'cep': data['cep'],
    'logradouro': data['logradouro'],
    'bairro': data['bairro'],
    'localidade': data['localidade'],
    'uf': data['uf'],   
  };

  emit(CepLoaded(filteredData));
} catch (e) {
  emit(CepError('Erro ao buscar o CEP'));
}
  }
}
