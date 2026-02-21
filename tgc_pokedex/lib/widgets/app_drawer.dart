// widgets/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:tgc_pokedex/views/homePage.dart';
import 'package:tgc_pokedex/views/searchPage.dart';
import 'package:tgc_pokedex/views/explorePage.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFFEE1515);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.catching_pokemon,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  'PokéDex TCG',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: primaryColor),
            title: Text(
              'Accueil',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search, color: primaryColor),
            title: Text(
              'Recherche',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.explore, color: primaryColor),
            title: Text(
              'Explorer',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}