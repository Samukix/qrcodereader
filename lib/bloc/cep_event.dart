abstract class CepEvent {}

class GetCep extends CepEvent {
  final String cep;

  GetCep(this.cep);
}
