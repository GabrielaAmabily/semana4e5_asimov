import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

class FiltrosScreen extends ConsumerWidget {
  const FiltrosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lê o estado atual (rebuild quando muda)
    final filtros = ref.watch(filtrosProvider);

    // Pega o controlador para alterar o estado
    final filtrosNotifier = ref.read(filtrosProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus Filtros'),
        actions: [
          IconButton(
            tooltip: 'Limpar filtros',
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              filtrosNotifier.limparTudo();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: filtros.semGluten,
            onChanged: (valor) => filtrosNotifier.definirSemGluten(valor),
            title: const Text('Sem Glúten'),
            subtitle: const Text('Mostrar apenas itens sem glúten'),
          ),
          SwitchListTile(
            value: filtros.semLactose,
            onChanged: (valor) => filtrosNotifier.definirSemLactose(valor),
            title: const Text('Sem Lactose'),
            subtitle: const Text('Mostrar apenas itens sem lactose'),
          ),
          SwitchListTile(
            value: filtros.semAcucar,
            onChanged: (valor) => filtrosNotifier.definirSemAcucar(valor),
            title: const Text('Sem Açúcar'),
            subtitle: const Text('Mostrar apenas itens sem açúcar'),
          ),
        ],
      ),
    );
  }
}
