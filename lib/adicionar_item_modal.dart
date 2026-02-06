import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categoria.dart';
import 'classe_item.dart';
import 'providers.dart';

class AdicionarItemModal extends ConsumerStatefulWidget {
  const AdicionarItemModal({super.key});

  @override
  ConsumerState<AdicionarItemModal> createState() => _AdicionarItemModalState();
}

class _AdicionarItemModalState extends ConsumerState<AdicionarItemModal> {
  // controllers dos campos de texto
  final _nomeCtrl = TextEditingController();
  final _precoCtrl = TextEditingController();
  final _imageUrlCtrl = TextEditingController();
  final _ingredientesCtrl = TextEditingController(); // separados por vírgula

  // estado do form
  Categoria? _categoriaSelecionada;

  bool _semGluten = false;
  bool _semLactose = false;
  bool _semAcucar = false;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _precoCtrl.dispose();
    _imageUrlCtrl.dispose();
    _ingredientesCtrl.dispose();
    super.dispose();
  }

  void _salvar() {
    final nome = _nomeCtrl.text.trim();
    final imageUrl = _imageUrlCtrl.text.trim();

    // aceita "10,50" ou "10.50"
    final precoTexto = _precoCtrl.text.trim().replaceAll(',', '.');
    final preco = double.tryParse(precoTexto);

    final categoria = _categoriaSelecionada;

    if (nome.isEmpty || preco == null || preco <= 0 || categoria == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha nome, preço válido e categoria.'),
        ),
      );
      return;
    }

    // ingredientes: "leite, canela, chocolate" -> ["leite","canela","chocolate"]
    final ingredientes = _ingredientesCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final novoItem = Item(
      nome: nome,
      preco: preco,
      imageUrl: imageUrl.isEmpty
          ? 'https://via.placeholder.com/300' // fallback simples
          : imageUrl,
      categoria: categoria,
      ingredientes: ingredientes,
      isGlutenFree: _semGluten,
      isLactoseFree: _semLactose,
      isSemAcucar: _semAcucar,
    );

    // ✅ atualiza estado global
    ref.read(itensStateProvider.notifier).adicionarItem(novoItem);

    // fecha o modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // lista de categorias já existente no seu projeto
    // (pelo seu categorias.dart, você usa "categoriasDisponiveis")
    final categorias = categoriasDisponiveis;

    return Padding(
      // ✅ isso faz o modal subir quando o teclado aparece
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Adicionar item',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _nomeCtrl,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _precoCtrl,
              decoration: const InputDecoration(
                labelText: 'Preço (ex: 9,50)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _imageUrlCtrl,
              decoration: const InputDecoration(
                labelText: 'URL da imagem (opcional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<Categoria>(
              value: _categoriaSelecionada,
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
              ),
              items: categorias
                  .map(
                    (cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat.title),
                    ),
                  )
                  .toList(),
              onChanged: (cat) {
                setState(() {
                  _categoriaSelecionada = cat;
                });
              },
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _ingredientesCtrl,
              decoration: const InputDecoration(
                labelText: 'Ingredientes (separe por vírgula)',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 12),

            SwitchListTile(
              value: _semGluten,
              onChanged: (v) => setState(() => _semGluten = v),
              title: const Text('Sem glúten'),
            ),
            SwitchListTile(
              value: _semLactose,
              onChanged: (v) => setState(() => _semLactose = v),
              title: const Text('Sem lactose'),
            ),
            SwitchListTile(
              value: _semAcucar,
              onChanged: (v) => setState(() => _semAcucar = v),
              title: const Text('Sem açúcar'),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _salvar,
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
