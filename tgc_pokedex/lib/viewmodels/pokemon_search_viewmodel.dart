// viewmodels/pokemon_search_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:tgc_pokedex/models/pokemon.dart';
import 'package:tgc_pokedex/services/pokemon_service.dart';

class PokemonSearchViewModel extends ChangeNotifier {
  final PokemonService _service;

  PokemonSearchViewModel(this._service);

  String _searchQuery = '';
  List<PokemonCard> _cards = [];
  bool _loading = false;
  String? _errorMessage;

  String get searchQuery => _searchQuery;
  List<PokemonCard> get cards => _cards;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> searchPokemon() async {
    if (_searchQuery.isEmpty) {
      _errorMessage = 'Veuillez entrer le nom du Pokémon';
      _cards = [];
      notifyListeners();
      return;
    }

    _loading = true;
    _errorMessage = null;
    _cards = [];
    notifyListeners();

    try {
      _cards = await _service.searchCards(_searchQuery);

      if (_cards.isEmpty) {
        _errorMessage = 'Aucune carte trouvée pour "$_searchQuery"';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _cards = [];
    _errorMessage = null;
    _loading = false;
    notifyListeners();
  }
}