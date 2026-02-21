// views/detailPage.dart

import 'package:flutter/material.dart';
import 'package:tgc_pokedex/models/pokemon.dart';

class DetailPage extends StatelessWidget {
  final PokemonCard card;

  const DetailPage({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFFEE1515);

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: primaryColor,
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                card.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: 'card_${card.id}',
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        primaryColor,
                        primaryColor.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: card.imageLarge != null
                      ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.network(
                      card.imageLarge!,
                      fit: BoxFit.contain,
                    ),
                  )
                      : Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildInfoRow('ID', card.id),
                          if (card.supertype != null)
                            _buildInfoRow('Supertype', card.supertype!),
                          if (card.hp != null)
                            _buildInfoRow('Points de vie', '${card.hp} HP',
                                color: primaryColor),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}