import 'package:flutter/material.dart';
import 'package:tgc_pokedex/views/searchPage.dart';
import 'package:tgc_pokedex/views/explorePage.dart';
import 'package:tgc_pokedex/views/detailPage.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text(' Page de recherche'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text(' Page exploration'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Page de détails '),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
