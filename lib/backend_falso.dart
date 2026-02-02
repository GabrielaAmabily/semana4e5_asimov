//dummy_data no curso
//instaciando a classe item

import 'classe_item.dart';
import 'categoria.dart';

final cafes = categoriasDisponiveis.firstWhere((c) => c.id == 'c1');
final sucos = categoriasDisponiveis.firstWhere((c) => c.id == 'c2');
final refrigerantes = categoriasDisponiveis.firstWhere((c) => c.id == 'c3');
final salgados = categoriasDisponiveis.firstWhere((c) => c.id == 'c4');
final bolos = categoriasDisponiveis.firstWhere((c) => c.id == 'c5');
final doces = categoriasDisponiveis.firstWhere((c) => c.id == 'c6');
final lanches = categoriasDisponiveis.firstWhere((c) => c.id == 'c7');


final List<Item> itens = [
  Item(
    nome: 'Café expresso',
    preco: 8.0,
    imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93',
    categoria: cafes,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Café com Leite',
    preco: 5.0,
    imageUrl: 'https://images.unsplash.com/photo-1521302080334-4bebac2763a6',
    categoria: cafes,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Capuccino',
    preco: 12.00,
    imageUrl: 'assets/imagens/capuccino.png',
    categoria: cafes,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Croissant',
    preco: 8.00,
    imageUrl: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73',
    categoria: salgados,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Bolo de Chocolate',
    preco: 9.50,
    imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c',
    categoria: bolos,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Suco de Laranja',
    preco: 8.00,
    imageUrl: 'assets/imagens/suco_laranja.png',
    categoria: sucos,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Água',
    preco: 3.00,
    imageUrl: 'assets/imagens/agua.png',
    categoria: refrigerantes,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Pão de Quiejo',
    preco: 5.30,
    imageUrl: 'assets/imagens/paodequeijo.png',
    categoria: salgados,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
  Item(
    nome: 'Risole',
    preco: 6.50,
    imageUrl: 'assets/imagens/risole.png',
    categoria: salgados,
    ingredientes: [
      
    ],
    isGlutenFree: true,
    isLactoseFree: true,
    isSemAcucar: true,
  ),
];
