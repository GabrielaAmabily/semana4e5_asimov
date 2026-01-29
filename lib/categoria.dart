// estrutura da categoria
import 'package:flutter/material.dart';

class Categoria {
  const Categoria({
    required this.id,
    required this.title,
    this.color = Colors.brown,
  });

  final String id;
  final String title;
  final Color color;
}

// dummy

const List<Categoria> categoriasDisponiveis = [
  Categoria(
    id: 'c1',
    title: 'Cafés',
    color: Colors.amberAccent,
  ),
  Categoria(
    id: 'c2',
    title: 'Sucos',
    color: Colors.orange,
  ),
  Categoria(
    id: 'c3',
    title: 'Refrigerantes',
    color: Colors.blueAccent,
  ),
  Categoria(
    id: 'c4',
    title: 'Salgados',
    color: Colors.amberAccent,
  ),
  Categoria(
    id: 'c5',
    title: 'Bolos',
    color: Colors.pinkAccent,
  ),
  Categoria(
    id: 'c6',
    title: 'Doces',
    color: Colors.purpleAccent,
  ),
  Categoria(
    id: 'c7',
    title: 'Lanches',
    color: Colors.redAccent,
  ),
];
