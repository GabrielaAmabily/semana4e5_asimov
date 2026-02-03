import 'package:flutter/material.dart';
import 'classe_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.itens,
  });

  final String title;
  final List<Item> itens;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: itens.length,
      itemBuilder: (ctx, index) => Text(itens[index].nome),
    );

    if (itens.isEmpty) {
      content = const Center(child: Text(
        'Opa! Nada aqui ainda!',
        style: TextStyle(fontSize: 20),));
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: content,
    );
  }
}
