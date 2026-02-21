// services/pokemon_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tgc_pokedex/models/pokemon.dart';

class PokemonService {
  final String _apiKey;

  PokemonService(this._apiKey);

  Future<List<PokemonCard>> fetchCards({int page = 1, int pageSize = 20}) async {
    try {
      final uri = Uri.parse(
        'https://api.pokemontcg.io/v2/cards?page=$page&pageSize=$pageSize',
      );

      final response = await http.get(
        uri,
        headers: {
          'X-Api-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => PokemonCard.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<List<PokemonCard>> searchCards(String query) async {
    try {
      final formattedQuery = query.replaceAll(' ', '+');
      final uri = Uri.parse(
        'https://api.pokemontcg.io/v2/cards?q=name:$formattedQuery',
      );

      final response = await http.get(
        uri,
        headers: {
          'X-Api-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded['data'];
        return data.map((json) => PokemonCard.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}