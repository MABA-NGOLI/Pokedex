// views/searchPage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgc_pokedex/viewmodels/pokemon_search_viewmodel.dart';
import 'package:tgc_pokedex/services/pokemon_service.dart';
import 'package:tgc_pokedex/widgets/app_drawer.dart';
import 'package:tgc_pokedex/views/detailPage.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiKey = const String.fromEnvironment('API_KEY');

    return ChangeNotifierProvider(
      create: (_) => PokemonSearchViewModel(PokemonService(apiKey)),
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
    final primaryColor = Color(0xFFEE1515);
    final accentColor = Color(0xFFFFCB05);
    final backgroundColor = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Recherche Pokémon',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Entrez le nom d\'un Pokémon',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  suffixIcon: viewModel.searchQuery.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _controller.clear();
                      viewModel.clearSearch();
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: viewModel.setSearchQuery,
                onSubmitted: (_) => viewModel.searchPokemon(),
              ),
            ),
            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: viewModel.searchPokemon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: primaryColor.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Rechercher',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: viewModel.loading
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: primaryColor),
                    SizedBox(height: 16),
                    Text(
                      'Recherche en cours...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
                  : viewModel.errorMessage != null
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      viewModel.errorMessage!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                  : viewModel.cards.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.catching_pokemon,
                      size: 80,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Recherchez un Pokémon\npour commencer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      '${viewModel.cards.length} résultat(s) trouvé(s)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.68,
                      ),
                      itemCount: viewModel.cards.length,
                      itemBuilder: (context, index) {
                        final card = viewModel.cards[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(card: card),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'card_${card.id}',
                            child: Card(
                              elevation: 4,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(16),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Colors.grey.shade50,
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                        child: card.imageSmall != null
                                            ? Image.network(
                                          card.imageSmall!,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (context, child,
                                              progress) {
                                            if (progress ==
                                                null)
                                              return child;
                                            return Center(
                                              child:
                                              CircularProgressIndicator(
                                                value: progress
                                                    .expectedTotalBytes !=
                                                    null
                                                    ? progress
                                                    .cumulativeBytesLoaded /
                                                    progress
                                                        .expectedTotalBytes!
                                                    : null,
                                                color:
                                                primaryColor,
                                                strokeWidth: 2,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (_, __, ___) =>
                                              Container(
                                                color: Colors
                                                    .grey[200],
                                                child: Icon(
                                                  Icons
                                                      .image_not_supported,
                                                  size: 48,
                                                  color: Colors
                                                      .grey[400],
                                                ),
                                              ),
                                        )
                                            : Container(
                                          color: Colors
                                              .grey[200],
                                          child: Icon(
                                            Icons
                                                .image_not_supported,
                                            size: 48,
                                            color: Colors
                                                .grey[400],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              card.name,
                                              textAlign:
                                              TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            if (card.hp !=
                                                null) ...[
                                              SizedBox(height: 4),
                                              Container(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                  horizontal: 8,
                                                  vertical: 2,
                                                ),
                                                decoration:
                                                BoxDecoration(
                                                  color: primaryColor
                                                      .withOpacity(
                                                      0.1),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      12),
                                                ),
                                                child: Text(
                                                  'HP ${card.hp}',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600,
                                                    color:
                                                    primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}