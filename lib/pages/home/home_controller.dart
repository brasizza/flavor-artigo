import 'package:app_flavor/data/models/cep_model.dart';
import 'package:app_flavor/data/repository/cep_repository.dart';

class HomeController {
  final CepRepository _repository;

  HomeController({required CepRepository repository}) : _repository = repository;

  Future<CepModel?> buscarCep({required String cep}) async {
    return await _repository.buscarCep(cep: cep);
  }
}
