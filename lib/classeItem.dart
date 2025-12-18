class Item {
  final String nome;
  final double preco;
  final String imageUrl;
  final String categoria;
  bool favorito;

  Item({
    required this.nome,
    required this.preco,
    required this.imageUrl,
    required this.categoria,
    this.favorito = false,
  });
}
