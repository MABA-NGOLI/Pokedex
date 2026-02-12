import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text(
          'Contenu de la page Détails',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
