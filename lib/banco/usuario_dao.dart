import 'package:mimpedir/banco/database_helper.dart';
import '../usuario.dart';


class UsuarioDAO {
  static Usuario usuarioLogado = Usuario();


  static Future<bool> autenticar(String login, String senha) async {
    final db = await DatabaseHelper.getDataBase();


    final resultado = await db.query(
      'tb_usuario',
      where: 'nm_login = ? and ds_senha = ?',
      whereArgs: [login, senha],
    );


    if (resultado.isNotEmpty) {
      final row = resultado.first;


      usuarioLogado.codigo = row['cd_usuario'] as int?;
      usuarioLogado.nome = row['nm_usuario'] as String?;
      usuarioLogado.login = row['nm_login'] as String?;
      usuarioLogado.senha = row['ds_senha'] as String?;


      return true;
    }


    return false;
  }
}
