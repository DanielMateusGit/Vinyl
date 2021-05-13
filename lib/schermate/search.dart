import 'package:flutter/material.dart';
import 'package:vinyl/componenti/barra_navigazione.dart';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Container(
          ),
        ),

        bottomNavigationBar: barra_navigazione(),

      ),
    );
  }
}

