abstract class CepState {}

class CepInitial extends CepState {}

class CepLoading extends CepState {}

class CepLoaded extends CepState {
  final Map<String, dynamic> data;

  CepLoaded(this.data);
}

class CepError extends CepState {
  final String message;

  CepError(this.message);
}
