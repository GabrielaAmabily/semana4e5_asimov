//meal_details. dart 
//tela de detalhes

import 'package:flutter/material.dart';
import 'classe_item.dart';

class ItemDetalhesScreen extends StatefulWidget {
  const ItemDetalhesScreen({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  State<ItemDetalhesScreen> createState() => _ItemDetalhesScreenState();
}

class _ItemDetalhesScreenState extends State<ItemDetalhesScreen> {
   void _toggleFavorito() {
    setState(() {
      widget.item.favorito = !widget.item.favorito;
    });
  }


  @override
  Widget build(BuildContext context) {

   return Scaffold(
    appBar: AppBar(
      title: Text(widget.item.nome),
      actions: [
  Padding(
    padding: const EdgeInsets.only(right: 8), // ajusta aqui
    child: IconButton(
      icon: Icon(
        widget.item.favorito ? Icons.favorite : Icons.favorite_border,
        color: widget.item.favorito ? Colors.red : null,
      ),
      onPressed: _toggleFavorito,
    ),
  ),
],
    ),
    body: Column(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,//ocupe todo espaço

          //tratamento entre url e asset dnv 
          child: widget.item.imageUrl.startsWith('http')
            ? Image.network(
                widget.item.imageUrl,
                fit: BoxFit.cover,
              )
            : Image.asset(
                widget.item.imageUrl,
                fit: BoxFit.cover,
      ),
          //fim do tratamento
        ),
        const SizedBox(height: 14),


        Text(
          'Ingredientes',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox( height: 14),


        for (final ingrediente in widget.item.ingredientes) 
          Text(
            ingrediente,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
      ],    
    ),
    );
  }
}