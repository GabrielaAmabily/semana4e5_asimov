import 'package:flutter/material.dart';

class FiltrosScreen extends StatefulWidget {
  const FiltrosScreen({super.key, required this.filtrosAtuais});

  final Map<String, bool> filtrosAtuais;

  @override
  State<FiltrosScreen> createState() => _FiltrosScreenState();
}

class _FiltrosScreenState extends State<FiltrosScreen> {
  var _semGlutenFiltroSet = false;
  var _semLactoseFiltroSet = false;
  var _semAcucarFiltroSet = false;

  @override
  void initState() {
    super.initState();
    _semGlutenFiltroSet = widget.filtrosAtuais['semGluten'] ?? false;
    _semLactoseFiltroSet = widget.filtrosAtuais['semLactose'] ?? false;
    _semAcucarFiltroSet = widget.filtrosAtuais['semAcucar'] ?? false;
  }

  void _sairSalvando() {
    Navigator.of(context).pop({
      'semGluten': _semGlutenFiltroSet,
      'semLactose': _semLactoseFiltroSet,
      'semAcucar': _semAcucarFiltroSet,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus Filtros'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _sairSalvando),
        ],
      ),

      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;

          Navigator.of(context).pop({
            'semGluten': _semGlutenFiltroSet,
            'semLactose': _semLactoseFiltroSet,
            'semAcucar': _semAcucarFiltroSet,
          });
        },

        
        child: Column(
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
                'Mostrar apenas itens sem glúten',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            SwitchListTile(
              value: _semLactoseFiltroSet,
              onChanged: (isChecked) {
                setState(() {
                  _semLactoseFiltroSet = isChecked;
                });
              },
              title: Text(
                'Sem Lactose',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Mostrar apenas itens sem lactose',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            SwitchListTile(
              value: _semAcucarFiltroSet,
              onChanged: (isChecked) {
                setState(() {
                  _semAcucarFiltroSet = isChecked;
                });
              },
              title: Text(
                'Sem Açúcar',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Mostrar apenas itens sem açúcar',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
