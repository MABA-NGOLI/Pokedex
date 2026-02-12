import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exploration'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text(
          'Contenu de la page Exploration',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
