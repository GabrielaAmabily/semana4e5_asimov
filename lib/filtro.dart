//filters.dart

import 'package:flutter/material.dart';

class FiltrosScreen extends StatefulWidget {
  const FiltrosScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FiltrosScreenState();
  }
}

class _FiltrosScreenState extends State<FiltrosScreen> {
  var _semGlutenFiltroSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seus Filtros')),
      body: Column(
        children: [
          SwitchListTile(
            value: _semGlutenFiltroSet,
              onChanged: (isChecked) {
                setState(() {
                  _semGlutenFiltroSet = isChecked;
                });
              },
            title: Text(
              'Sem Glúten',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Mostrar apenas refeições sem glúten',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            //activeColor tbm nao usa mais
          ),
        ],
      ),
    );
  }
}
