import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum TipoCategoria { cafes, sucos, refrigerante, salgados, bolos, doces, lanches }

class Item {
  final String id;
  final String nome;
  final double preco;
  final String imageUrl;
  final TipoCategoria categoria;
  bool favorito;

  Item({
    required this.nome,
    required this.preco,
    required this.imageUrl,
    required this.categoria,
    this.favorito = false,
  }) : id = uuid.v4();
}
