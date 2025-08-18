import 'package:flutter/material.dart';
import 'usuario.dart';
import 'tipo.dart';
import 'restaurante.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Criando o usuário (proprietário)
    Usuario usuario = Usuario(
      codigo: 1,
      nome: "Eduarda",
      login: "dudah12",
      senha: "@duquesa",
    );

    // Criando o tipo de culinária
    Tipo tipo = Tipo(
      codigo: 2,
      nome: "Japonesa",
    );

    // Criando o restaurante
    Restaurante restaurante = Restaurante(
      codigo: 101,
      nome: "Sushi Bom",
      latitude: -23.5505,
      longitude: -46.6333,
      proprietario: usuario,
      tipoCulinaria: tipo,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dados do Restaurante"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Código do Restaurante: ${restaurante.codigo}"),
              Text("Nome: ${restaurante.nome}"),
              Text("Localização: ${restaurante.latitude}, ${restaurante.longitude}"),
              const SizedBox(height: 10),
              Text("Proprietário: ${restaurante.proprietario?.nome}"),
              Text("Login do Proprietário: ${restaurante.proprietario?.login}"),
              const SizedBox(height: 10),
              Text("Tipo de Culinária: ${restaurante.tipoCulinaria?.nome}"),
            ],
          ),
        ),
      ),
    );
  }
}