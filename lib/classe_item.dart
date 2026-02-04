//meal.dart no curso?

import 'package:uuid/uuid.dart';
import 'categoria.dart';


const uuid = Uuid();

//enum TipoCategoria { cafes, sucos, refrigerante, salgados, bolos, doces, lanches }

class Item {
  final String id;
  final String nome;
  final double preco;
  final String imageUrl;
  final Categoria categoria;
  final List<String> ingredientes;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isSemAcucar;
  bool favorito;

  Item({
    required this.nome,
    required this.preco,
    required this.imageUrl,
    required this.categoria,
    required this.ingredientes,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isSemAcucar,
    this.favorito = false,
  }) : id = uuid.v4();
}
