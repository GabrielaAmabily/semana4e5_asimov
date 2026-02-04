import 'package:flutter/material.dart';
import 'classe_item.dart';
import 'item_card.dart';
import 'item_detalhes.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key, required this.title, required this.itens});

  final String title;
  final List<Item> itens;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  void _selecionaItem(Item item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ItemDetalhesScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: widget.itens.length,
      itemBuilder: (context, index) {
        final item = widget.itens[index];

        return ItemCard(
          item: item,
          onSelecionaItem: _selecionaItem, // ✅ agora funciona
          onFavoriteToggle: () {
            setState(() {
              item.favorito = !item.favorito;
            });
          },
        );
      },
    );

    if (widget.itens.isEmpty) {
      content = const Center(
        child: Text('Opa! Nada aqui ainda!', style: TextStyle(fontSize: 20)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}
