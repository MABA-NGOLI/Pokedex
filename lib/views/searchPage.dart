import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text(
          'Contenu de la page Recherche',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
