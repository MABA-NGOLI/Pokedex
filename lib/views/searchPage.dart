import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgc_pokedex/services/pokemon_search.dart';
import 'package:tgc_pokedex/widgets/app_drawer.dart';
import 'package:tgc_pokedex/models/pokemon.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PokemonSearchViewModel(),
      child: PokemonSearchPageContent(),
    );
  }
}

class PokemonSearchPageContent extends StatefulWidget {
  @override
  _PokemonSearchPageContentState createState() =>
      _PokemonSearchPageContentState();
}

class _PokemonSearchPageContentState extends State<PokemonSearchPageContent> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokemonSearchViewModel>();
    final primaryColor = Colors.blue.shade700;
    final accentColor = Colors.blue.shade400;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon TCG Search'),
        backgroundColor: primaryColor,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Champ de recherche
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Nom du Pokémon',
                prefixIcon: Icon(Icons.search, color: primaryColor),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: viewModel.setSearchQuery,
            ),
            SizedBox(height: 12),

            // Bouton Rechercher
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: viewModel.searchPokemon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Rechercher',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 12),

            // Résultats
            Expanded(
              child: viewModel.loading
                  ? Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
                  : viewModel.errorMessage != null
                  ? Center(
                child: Text(
                  viewModel.errorMessage!,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              )
                  : viewModel.cards.isEmpty
                  ? Center(
                child: Text(
                  'Entrez un Pokémon et cliquez sur "Rechercher"',
                  textAlign: TextAlign.center,
                ),
              )
                  : GridView.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: viewModel.cards.length,
                itemBuilder: (context, index) {
                  final card = viewModel.cards[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            card.image ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.image_not_supported),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            card.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}