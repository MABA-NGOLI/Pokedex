// views/explorePage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgc_pokedex/viewmodels/explore_viewmodel.dart';
import 'package:tgc_pokedex/services/pokemon_service.dart';
import 'package:tgc_pokedex/widgets/app_drawer.dart';
import 'package:tgc_pokedex/views/detailPage.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiKey = const String.fromEnvironment('API_KEY');

    return ChangeNotifierProvider(
      create: (_) => ExploreViewModel(PokemonService(apiKey)),
      child: ExplorePageContent(),
    );
  }
}

class ExplorePageContent extends StatefulWidget {
  @override
  _ExplorePageContentState createState() => _ExplorePageContentState();
}

class _ExplorePageContentState extends State<ExplorePageContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final viewModel = context.read<ExploreViewModel>();
      viewModel.loadMoreCards();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExploreViewModel>();
    final primaryColor = Color(0xFFEE1515);
    final backgroundColor = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Explorer les Cartes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: viewModel.refresh,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: viewModel.loading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: primaryColor),
            SizedBox(height: 16),
            Text(
              'Chargement des cartes...',
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                viewModel.errorMessage!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: viewModel.refresh,
                icon: Icon(Icons.refresh),
                label: Text('Réessayer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
          : RefreshIndicator(
        onRefresh: () async {
          viewModel.refresh();
        },
        color: primaryColor,
        child: GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemCount: viewModel.cards.length + (viewModel.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == viewModel.cards.length) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
              );
            }

            final card = viewModel.cards[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(card: card),
                  ),
                );
              },
              child: Hero(
                tag: 'card_${card.id}',
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: card.imageSmall != null
                                ? Image.network(
                              card.imageSmall!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                        progress.expectedTotalBytes!
                                        : null,
                                    color: primaryColor,
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                              ),
                            )
                                : Container(
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  card.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                if (card.hp != null) ...[
                                  SizedBox(height: 4),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'HP ${card.hp}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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
    );
  }
}