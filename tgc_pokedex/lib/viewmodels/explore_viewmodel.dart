// viewmodels/explore_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:tgc_pokedex/models/pokemon.dart';
import 'package:tgc_pokedex/services/pokemon_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final PokemonService _service;

  ExploreViewModel(this._service) {
    loadCards();
  }

  List<PokemonCard> _cards = [];
  bool _loading = false;
  bool _loadingMore = false;
  String? _errorMessage;
  int _currentPage = 1;
  bool _hasMore = true;

  List<PokemonCard> get cards => _cards;
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  Future<void> loadCards() async {
    if (_loading) return;

    _loading = true;
    _errorMessage = null;
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();

    try {
      final newCards = await _service.fetchCards(page: _currentPage);
      _cards = newCards;

      if (newCards.length < 20) {
        _hasMore = false;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCards() async {
    if (_loadingMore || !_hasMore || _loading) return;

    _loadingMore = true;
    notifyListeners();

    try {
      _currentPage++;
      final newCards = await _service.fetchCards(page: _currentPage);

      if (newCards.isEmpty || newCards.length < 20) {
        _hasMore = false;
      }

      _cards.addAll(newCards);
    } catch (e) {
      _errorMessage = e.toString();
      _currentPage--;
    } finally {
      _loadingMore = false;
      notifyListeners();
    }
  }

  void refresh() {
    loadCards();
  }
}