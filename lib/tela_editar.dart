import 'package:flutter/cupertino.dart';
import 'package:mimpedir/restaurante.dart';
import 'package:mimpedir/tipo.dart';
import 'banco/restaurante_DAO.dart';
import 'banco/tipo_DAO.dart';

class TelaEditar extends StatefulWidget {
//restaurante que será exibido na tela
  static Restaurante restaurante = Restaurante();

  @override
  State<StatefulWidget> createState() {
    return TelaEditarState();
  }
}
class TelaEditarState extends State<TelaEditar>{

  final TextEditingController cdController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  String? culinariaSelecionada;
  List<Tipo> tiposCulinaria = [];
  int? tipoCulinaria;
  int? codigo = TelaEditar.restaurante.codigo as int;

  void initState() {
    super.initState();
    carregarTipos();
    cdController.text = TelaEditar.restaurante.codigo.toString()!;
    nomeController.text = TelaEditar.restaurante.nome!;
    latitudeController.text = TelaEditar.restaurante.latitude.toString()!;
    longitudeController.text = TelaEditar.restaurante.longitude.toString()!;
    tipoCulinaria = TelaEditar.restaurante.culinaria?.codigo!;
    culinariaSelecionada = TelaEditar.restaurante.culinaria?.descricao
  }

  Future<void> carregarTipos()async{
    final lista = await TipoDAO.listarTipos();
    setState(() {
      tiposCulinaria = lista;
    });
  }
}