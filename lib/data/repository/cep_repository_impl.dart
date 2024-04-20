import 'package:app_flavor/data/models/cep_model.dart';
import 'package:dio/dio.dart';

import './cep_repository.dart';

class CepRepositoryImpl implements CepRepository {
  final Dio _dio;

  CepRepositoryImpl({required Dio dio}) : _dio = dio;
  @override
  Future<CepModel?> buscarCep({required String cep}) async {
    String url = "https://viacep.com.br/ws/$cep/json/";

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        if ((response.data as Map).containsKey('erro')) {
          throw Exception('Cep invalido - ${response.data}');
        }
        return CepModel.fromMap(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
