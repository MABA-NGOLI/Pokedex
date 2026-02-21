// views/homePage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgc_pokedex/viewmodels/home_viewmodel.dart';
import 'package:tgc_pokedex/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: HomePageContent(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final primaryColor = Color(0xFFEE1515);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModel.title,
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.catching_pokemon,
                    size: 100,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Bienvenue dans le',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'PokéDex TCG',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Explorez et recherchez vos cartes Pokémon préférées !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.swipe, color: Colors.grey[400]),
                    SizedBox(width: 8),
                    Text(
                      'Utilisez le menu pour commencer',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}