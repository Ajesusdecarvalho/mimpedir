import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final _nomeBanco = 'Solucao_Completa.db';
  static Database? _db;


  static Future<Database> getDataBase() async {
    if (_db != null) return _db!;


    Directory pastabanco = await getApplicationDocumentsDirectory();
    String caminho = join(pastabanco.path, _nomeBanco);


    if (!File(caminho).existsSync()) {
// copia db pré-populado dos assets
      ByteData data = await rootBundle.load('assets/$_nomeBanco');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(caminho).writeAsBytes(bytes);
    }


    _db = await openDatabase(caminho);
    return _db!;
  }
}