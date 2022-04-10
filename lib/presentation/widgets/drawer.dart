import 'package:flutter/material.dart';

import '../pages/about_page.dart';

class DrawerWidgets extends StatelessWidget {
  final Function() onTapMovie;
  final Function() onTapTv;
  final Function() onTapWatchlist;

  DrawerWidgets(
      {required this.onTapMovie,
      required this.onTapTv,
      required this.onTapWatchlist});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: onTapMovie,
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV Series'),
            onTap: onTapTv,
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: onTapWatchlist,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
