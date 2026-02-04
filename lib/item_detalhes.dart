//meal_details. dart 
//tela de detalhes

import 'package:flutter/material.dart';
import 'classe_item.dart';

class ItemDetalhesScreen extends StatelessWidget {
  const ItemDetalhesScreen({
    super.key,
    required this.item,
    });

  final Item item;


  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text(item.nome),
    ),
    body: Column(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,//ocupe todo espaço

          //tratamento entre url e asset dnv 
          child: item.imageUrl.startsWith('http')
          ? Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    item.imageUrl,
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


        for (final ingrediente in item.ingredientes) 
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