import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';//por causa de versao do flutter 

import 'backend_falso.dart';
import 'classe_item.dart';


//  lista inicial do backend falso - so leitura
final itensProvider = Provider<List<Item>>((ref) {
  return itens;
});

// Guarda a lista no estado para poder dar toggle no favorito.
class ItensNotifier extends StateNotifier<List<Item>> {
  ItensNotifier() : super([...itens]); // cópia da lista inicial

  // Alterna favorito de um item pelo id.
  void alternarFavorito(String itemId) {
    final listaAtualizada = [...state]; // nova lista (referência nova)

    final index = listaAtualizada.indexWhere((item) => item.id == itemId);
    if (index == -1) return;

    listaAtualizada[index].favorito = !listaAtualizada[index].favorito;
    state = listaAtualizada; // notifica quem está assistindo (watch)
  }

    // pra eu usar no modal
  void adicionarItem(Item novoItem) {
    
    state = [novoItem, ...state];
  }

  // pra quando for apagar item
void removerItem(String itemId) {
  state = state.where((item) => item.id != itemId).toList();
}

}

final itensStateProvider =
    StateNotifierProvider<ItensNotifier, List<Item>>((ref) {
  return ItensNotifier();
});


// Filtros estado global
class FiltrosState {
  final bool semGluten;
  final bool semLactose;
  final bool semAcucar;

  const FiltrosState({
    required this.semGluten,
    required this.semLactose,
    required this.semAcucar,
  });

  // Estado inicial: tudo desligado.
  const FiltrosState.inicial()
      : semGluten = false,
        semLactose = false,
        semAcucar = false;

  FiltrosState copyWith({
    bool? semGluten,
    bool? semLactose,
    bool? semAcucar,
  }) {
    return FiltrosState(
      semGluten: semGluten ?? this.semGluten,
      semLactose: semLactose ?? this.semLactose,
      semAcucar: semAcucar ?? this.semAcucar,
    );
  }
}

class FiltrosNotifier extends StateNotifier<FiltrosState> {
  FiltrosNotifier() : super(const FiltrosState.inicial());

  void definirSemGluten(bool valor) {
    state = state.copyWith(semGluten: valor);
  }

  void definirSemLactose(bool valor) {
    state = state.copyWith(semLactose: valor);
  }

  void definirSemAcucar(bool valor) {
    state = state.copyWith(semAcucar: valor);
  }

  void limparTudo() {
    state = const FiltrosState.inicial();
  }
}

final filtrosProvider =
    StateNotifierProvider<FiltrosNotifier, FiltrosState>((ref) {
  return FiltrosNotifier();
});


// nao guarda estado: só calculam com base no estado atual
final itensFiltradosProvider = Provider<List<Item>>((ref) {
  final listaItens = ref.watch(itensStateProvider);
  final filtros = ref.watch(filtrosProvider);

  return listaItens.where((item) {
    if (filtros.semGluten && !item.isGlutenFree) return false;
    if (filtros.semLactose && !item.isLactoseFree) return false;
    if (filtros.semAcucar && !item.isSemAcucar) return false;
    return true;
  }).toList();
});

final itensFavoritosFiltradosProvider = Provider<List<Item>>((ref) {
  final itensFiltrados = ref.watch(itensFiltradosProvider);
  return itensFiltrados.where((item) => item.favorito).toList();
});
