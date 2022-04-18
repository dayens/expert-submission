import 'package:about/about.dart';
import 'package:flutter/material.dart';

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
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: onTapMovie,
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Series'),
            onTap: onTapTv,
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: onTapWatchlist,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.routeName);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
