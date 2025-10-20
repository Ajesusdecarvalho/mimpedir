import 'package:mimpedir/banco/database_helper.dart';
import 'package:mimpedir/banco/usuario_dao.dart';
import 'package:mimpedir/restaurante.dart';
import 'package:mimpedir/tipo.dart';
import 'package:mimpedir/banco/tipo_dao.dart';

class RestauranteDAO {
  static Future<void> atualizar(int? cd, String? nome, String? lat, String? long, int? tipo)async{
    final db = await DatabaseHelper.getDataBase();
    final resultado = await db.update('tb_restaurante',
        {
          'nm_restaurante': nome,
          'latitude_restaurante': lat,
          'longitude_restaurante': long,
          'cd_tipo': tipo
        },
        where: 'cd_restaurante = ?',
        whereArgs: [cd]
    );
  }

  static Future<Restaurante> listar(int? cd) async {
    final db = await DatabaseHelper.getDataBase();
    final resultado = await db.query(
      'tb_restaurante',
      where: 'cd_restaurante = ?',
      whereArgs: [cd],
    );

    if (resultado.isEmpty) {
      throw Exception("Restaurante não encontrado");
    }

    final mapa = resultado.first;

    Tipo? tipo;
    if (mapa['cd_tipo'] != null) {
      tipo = await TipoDAO.listar(mapa['cd_tipo'] as int?);
    }

    return Restaurante(
      codigo: mapa['cd_restaurante'] as int?,
      nome: mapa['nm_restaurante'] as String?,
      latitude: mapa['latitude_restaurante'] as String?,
      longitude: mapa['longitude_restaurante'] as String?,
      tipoCulinaria: tipo,
    );
  }

  // lista todos os restaurantes do usuário logado — e busca o tipo para cada um
  static Future<List<Restaurante>> listarTodos() async {
    final db = await DatabaseHelper.getDataBase();

    final resultado = await db.query(
      'tb_restaurante',
      where: 'cd_usuario = ?',
      whereArgs: [UsuarioDAO.usuarioLogado.codigo],
    );

    final List<Restaurante> lista = [];

    for (final mapa in resultado) {
      Tipo? tipo;
      if (mapa['cd_tipo'] != null) {
        try {
          tipo = await TipoDAO.listar(mapa['cd_tipo'] as int?);
        } catch (_) {
          tipo = null;
        }
      }

      lista.add(Restaurante(
        codigo: mapa['cd_restaurante'] as int?,
        nome: mapa['nm_restaurante'] as String?,
        latitude: mapa['latitude_restaurante'] as String?,
        longitude: mapa['longitude_restaurante'] as String?,
        tipoCulinaria: tipo,
      ));
    }

    return lista;
  }

  // cadastra e retorna id (ou -1 em erro)
  static Future<int> cadastrarRestaurante(
      String? nome, String? latitude, String? longitude, int? tipo) async {
    final db = await DatabaseHelper.getDataBase();

    final dadosRestaurante = {
      'nm_restaurante': nome,
      'latitude_restaurante': latitude,
      'longitude_restaurante': longitude,
      'cd_tipo': tipo,
      'cd_usuario': UsuarioDAO.usuarioLogado.codigo,
    };

    try {
      final idRestaurante = await db.insert('tb_restaurante', dadosRestaurante);
      return idRestaurante;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao cadastrar restaurante: $e");
      return -1;
    }
  }

  // edita restaurante, retorna número de linhas afetadas
  static Future<int> editarRestaurante(int codigo, String? nome, String? latitude,
      String? longitude, int? tipo) async {
    final db = await DatabaseHelper.getDataBase();

    final dadosRestaurante = {
      'nm_restaurante': nome,
      'latitude_restaurante': latitude,
      'longitude_restaurante': longitude,
      'cd_tipo': tipo,
    };

    try {
      final linhas = await db.update(
        'tb_restaurante',
        dadosRestaurante,
        where: 'cd_restaurante = ?',
        whereArgs: [codigo],
      );
      return linhas;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao editar restaurante: $e");
      return -1;
    }
  }

  // exclui restaurante (retorna void, mas podemos também retornar int se preferir)
  static Future<void> excluir(Restaurante r) async {
    final db = await DatabaseHelper.getDataBase();
    await db.delete(
      'tb_restaurante',
      where: 'cd_restaurante = ?',
      whereArgs: [r.codigo],
    );
  }
}