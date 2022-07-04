// ignore_for_file: use_key_in_widget_constructors

import 'package:about/about.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerWidgets extends StatefulWidget {
  final Function() onTapMovie;
  final Function() onTapTv;
  final Function() onTapWatchlist;

  const DrawerWidgets(
      {required this.onTapMovie,
      required this.onTapTv,
      required this.onTapWatchlist});

  @override
  State<DrawerWidgets> createState() => _DrawerWidgetsState();
}

class _DrawerWidgetsState extends State<DrawerWidgets> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> data) {
                if (data.hasData) {
                  return UserAccountsDrawerHeader(
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage('assets/ic_ditonton.png'),
                    ),
                    accountName: Text(data.data!['nickname']),
                    accountEmail: Text(data.data!['email']),
                  );
                } else {
                  return const UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/ic_ditonton.png'),
                    ),
                    accountName: Text('Name'),
                    accountEmail: Text('Email'),
                  );
                }
              }),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: widget.onTapMovie,
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Series'),
            onTap: widget.onTapTv,
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: widget.onTapWatchlist,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.routeName);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                GoogleSignIn().signOut().then((value) {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                }).whenComplete(() {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Berhasil Keluar'),
                    duration: Duration(seconds: 1),
                  ));
                });
              });
            },
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
