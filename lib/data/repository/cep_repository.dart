import 'package:app_flavor/data/models/cep_model.dart';

abstract interface class CepRepository {
  Future<CepModel?> buscarCep({required String cep});
}
