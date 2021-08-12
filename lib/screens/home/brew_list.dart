import 'package:firebase_first/models/brew.dart';
import 'package:flutter/material.dart';
import 'brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    return ListView.builder(
      itemBuilder: (context, index) {
        return BrewTile(brews[index]);
      },
      itemCount: brews.length,
    );
  }
}
