// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CepModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String ddd;
  CepModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.ddd,
  });

  CepModel copyWith({
    String? cep,
    String? logradouro,
    String? complemento,
    String? bairro,
    String? localidade,
    String? ddd,
  }) {
    return CepModel(
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      localidade: localidade ?? this.localidade,
      ddd: ddd ?? this.ddd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'ddd': ddd,
    };
  }

  factory CepModel.fromMap(Map<String, dynamic> map) {
    return CepModel(
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      complemento: map['complemento'] as String,
      bairro: map['bairro'] as String,
      localidade: map['localidade'] as String,
      ddd: map['ddd'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CepModel.fromJson(String source) => CepModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CepModel(cep: $cep, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, localidade: $localidade, ddd: $ddd)';
  }

  @override
  bool operator ==(covariant CepModel other) {
    if (identical(this, other)) return true;

    return other.cep == cep && other.logradouro == logradouro && other.complemento == complemento && other.bairro == bairro && other.localidade == localidade && other.ddd == ddd;
  }

  @override
  int get hashCode {
    return cep.hashCode ^ logradouro.hashCode ^ complemento.hashCode ^ bairro.hashCode ^ localidade.hashCode ^ ddd.hashCode;
  }
}
