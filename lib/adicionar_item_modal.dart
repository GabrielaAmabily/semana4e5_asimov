import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categoria.dart';
import 'classe_item.dart';
import 'providers.dart';

class AdicionarItemModal extends ConsumerStatefulWidget {
  const AdicionarItemModal({super.key});

  @override
  ConsumerState<AdicionarItemModal> createState() {
    return _AdicionarItemModalState();
  }
}

class _AdicionarItemModalState extends ConsumerState<AdicionarItemModal> {
  // TextEditingController guarda o texto digitado
  // sem precisar usar onChanged
  final _nomeCtrl = TextEditingController();
  final _precoCtrl = TextEditingController();
  final _imageUrlCtrl = TextEditingController();
  final _ingredientesCtrl = TextEditingController();

  // Chave do formulário para validar
  final _formKey = GlobalKey<FormState>();

  // Estados locais do formulário
  Categoria? _categoriaSelecionada;
  DateTime? _dataLancamento;

  bool _semGluten = false;
  bool _semLactose = false;
  bool _semAcucar = false;

  //liberar os controllers quando o widget é destruído
  @override
  void dispose() {
    _nomeCtrl.dispose();
    _precoCtrl.dispose();
    _imageUrlCtrl.dispose();
    _ingredientesCtrl.dispose();
    super.dispose();
  }

  //aviso de erro
  void _mostrarErroDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Entrada inválida'),
        content: const Text(
          'Preencha corretamente o nome, preço, imagem, categoria e data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  //date picker
  Future<void> _selecionarData() async {
    final agora = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dataLancamento ?? agora,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate == null) return;

    setState(() {
      _dataLancamento = pickedDate;
    });
  }

  //salvar
  void _salvar() {
    final formValido = _formKey.currentState?.validate() ?? false;

    // Valida tudo antes de continuar
    if (!formValido || _categoriaSelecionada == null || _dataLancamento == null) {
      _mostrarErroDialog();
      return;
    }

    final preco = double.parse(_precoCtrl.text.replaceAll(',', '.'));

    final ingredientes = _ingredientesCtrl.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Criação do novo item
    final novoItem = Item(
      nome: _nomeCtrl.text.trim(),
      preco: preco,
      imageUrl: _imageUrlCtrl.text.trim(), // agora é obrigatório (sem imagem padrão)
      categoria: _categoriaSelecionada!,
      ingredientes: ingredientes,
      dataLancamento: _dataLancamento!,
      isGlutenFree: _semGluten,
      isLactoseFree: _semLactose,
      isSemAcucar: _semAcucar,
    );

    // Atualiza estado global com Riverpod
    ref.read(itensStateProvider.notifier).adicionarItem(novoItem);

    // Fecha o modal
    Navigator.of(context).pop();
  }

  //visual
  @override
  Widget build(BuildContext context) {
    final categorias = categoriasDisponiveis;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Adicionar item',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // NOME
              TextFormField(
                controller: _nomeCtrl,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // PREÇO
              TextFormField(
                controller: _precoCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final preco = double.tryParse(value ?? '');
                  if (preco == null || preco <= 0) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // IMAGEM (URL ou Asset)
              TextFormField(
                controller: _imageUrlCtrl,
                decoration: const InputDecoration(
                  labelText: 'Imagem (URL ou asset)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final v = (value ?? '').trim();
                  if (v.isEmpty) {
                    return 'Informe uma URL ou caminho de asset';
                  }

                  // Se parecer URL, valida o básico (http/https).
                  if (v.startsWith('http')) {
                    final uri = Uri.tryParse(v);
                    final ok = uri != null &&
                        (uri.scheme == 'http' || uri.scheme == 'https') &&
                        (uri.host.isNotEmpty);
                    if (!ok) return 'URL inválida';
                  }

                  // Se não for URL, assume asset (ItemImage já usa Image.asset).
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // CATEGORIA
              DropdownButtonFormField<Categoria>(
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                value: _categoriaSelecionada,
                items: categorias.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat.title),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _categoriaSelecionada = value;
                  });
                },
              ),

              const SizedBox(height: 12),

              // DATA
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _dataLancamento == null
                          ? 'Nenhuma data selecionada'
                          : 'Lançamento: '
                              '${_dataLancamento!.day.toString().padLeft(2, '0')}/'
                              '${_dataLancamento!.month.toString().padLeft(2, '0')}/'
                              '${_dataLancamento!.year}',
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _selecionarData,
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Escolher'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // BOTÕES
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: _salvar,
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
