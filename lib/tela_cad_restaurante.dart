import 'package:flutter/material.dart';
import 'package:mimpedir/banco/restaurante_DAO.dart';
import 'package:mimpedir/banco/tipo_DAO.dart';
import 'package:mimpedir/tipo.dart';

class TelaCadRestaurante extends StatefulWidget {
  const TelaCadRestaurante({super.key});

  @override
  State<StatefulWidget> createState() {
    return TelaCadRestauranteState();
  }
}

class TelaCadRestauranteState extends State<TelaCadRestaurante> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  String? culinariaSelecionada;
  List<Tipo> tiposCulinaria = [];
  int? tipoCulinaria;

  @override
  void initState() {
    super.initState();
    carregarTipos();
  }

  Future<void> carregarTipos() async {
    final lista = await TipoDAO.listarTipos();
    setState(() {
      tiposCulinaria = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro de Restaurante")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Informações do Restaurante:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              //tipos de culinária
              const Text("Tipo de comida:"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: culinariaSelecionada,
                hint: const Text("Selecione um tipo"),
                items: tiposCulinaria.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo.nome,
                    child: Text(tipo.nome ?? ''),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    culinariaSelecionada = value;
                    Tipo tipoSelecionado = tiposCulinaria.firstWhere(
                          (tipo) => tipo.nome == value,
                    );
                    tipoCulinaria = tipoSelecionado.codigo;
                  });
                },
              ),

              const SizedBox(height: 30),

              // Campos de texto
              TextFormField(
                decoration:
                const InputDecoration(hintText: 'Nome do Restaurante'),
                controller: nomeController,
              ),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(hintText: 'Latitude'),
                controller: latitudeController,
              ),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(hintText: 'Longitude'),
                controller: longitudeController,
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () async {
                  final sucesso = await RestauranteDAO.cadastrarRestaurante(
                    nomeController.text,
                    latitudeController.text,
                    longitudeController.text,
                    tipoCulinaria,
                  );

                  String msg = 'Erro: restaurante não cadastrado.';
                  Color corFundo = Colors.red;

                  if (sucesso > 0) {
                    msg =
                    '"${nomeController.text}" cadastrado com sucesso! ID: $sucesso';
                    corFundo = Colors.green;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                      backgroundColor: corFundo,
                      duration: const Duration(seconds: 4),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    SizedBox(width: 10),
                    Text("Cadastrar"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}