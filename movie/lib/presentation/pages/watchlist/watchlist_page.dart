import 'package:tvseries/presentation/pages/watchlist/watchlist_tvseries_page.dart';

import 'watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  int _bottomNavIndex = 0;
  static const String _movieText = 'Movie';
  static const String _tvText = 'Tv Series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
        currentIndex: _bottomNavIndex,
      ),
    );
  }

  final List<Widget> _listWidget = [
    const WatchlistMoviesPage(),
    const WatchlistTvSeriesPage()
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.movie), label: _movieText),
    const BottomNavigationBarItem(icon: Icon(Icons.tv), label: _tvText)
  ];
}
