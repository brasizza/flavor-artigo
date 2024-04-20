import 'package:app_flavor/data/models/cep_model.dart';
import 'package:app_flavor/data/repository/cep_repository_impl.dart';
import 'package:app_flavor/flavors.dart';
import 'package:app_flavor/pages/home/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  bool erro = false;
  String errorMessage = '';
  final cepEC = TextEditingController();
  CepModel? dadosCep;
  final HomeController controller = HomeController(
    repository: CepRepositoryImpl(
      dio: Dio(),
    ),
  );

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (F.appFlavor == Flavor.homolog && errorMessage != '')
          ? FloatingActionButton.small(
              child: (Icon(Icons.bug_report)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
              })
          : SizedBox(),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              'Buscar CEP',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) async {
                        _buscarCep(value);
                      },
                      keyboardType: TextInputType.number,
                      controller: cepEC,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Digite o cep',
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                        onPressed: (isLoading)
                            ? null
                            : () async {
                                _buscarCep(cepEC.text);
                              },
                        child: const Icon(Icons.search)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          (isLoading)
              ? const CircularProgressIndicator.adaptive()
              : (dadosCep == null)
                  ? Visibility(
                      visible: dadosCep == null && erro == false,
                      replacement: const Card(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Text('Falha ao buscar o cep'),
                        ),
                      ),
                      child: const SizedBox(),
                    )
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CEP: ${dadosCep?.cep ?? ''}'),
                            Text('Endereço: ${dadosCep?.logradouro ?? ''}'),
                            Visibility(visible: dadosCep?.complemento != '', child: Text('Complemento:  + ${dadosCep?.complemento ?? ''}')),
                            Text('Cidade: ${dadosCep?.logradouro ?? ''}'),
                            Text('DDD: ${dadosCep?.ddd ?? ''}'),
                          ],
                        ),
                      ),
                    )
        ],
      ),
    );
  }

  void _buscarCep(String cep) async {
    setState(() {
      erro = false;
      isLoading = true;
      errorMessage = '';
    });
    try {
      final cepModel = await controller.buscarCep(cep: cep);

      setState(() {
        dadosCep = cepModel;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        dadosCep = null;
        erro = true;
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }
}
