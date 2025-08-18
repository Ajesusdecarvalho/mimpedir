import 'usuario.dart';
import 'tipo.dart';

class Restaurante {
  int? _codigo;
  String? _nome;
  double? _latitude;
  double? _longitude;
  Usuario? _proprietario;
  Tipo? _tipoCulinaria;

  Restaurante({
    int? codigo,
    String? nome,
    double? latitude,
    double? longitude,
    Usuario? proprietario,
    Tipo? tipoCulinaria,
  }) {
    _codigo = codigo;
    _nome = nome;
    _latitude = latitude;
    _longitude = longitude;
    _proprietario = proprietario;
    _tipoCulinaria = tipoCulinaria;
  }

  // Getters
  int? get codigo => _codigo;
  String? get nome => _nome;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  Usuario? get proprietario => _proprietario;
  Tipo? get tipoCulinaria => _tipoCulinaria;

  // Setters
  set codigo(int? codigo) => _codigo = codigo;
  set nome(String? nome) => _nome = nome;
  set latitude(double? latitude) {
    _latitude = latitude;
  }

  set longitude(double? longitude) => _longitude = longitude;
  set proprietario(Usuario? proprietario) => _proprietario = proprietario;
  set tipoCulinaria(Tipo? tipoCulinaria) {
    _tipoCulinaria = tipoCulinaria;
  }
}