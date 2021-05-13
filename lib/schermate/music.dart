import 'package:flutter/material.dart';
import 'package:vinyl/componenti/barra_navigazione.dart';

class music extends StatefulWidget {
  @override
  _musicState createState() => _musicState();
}

class _musicState extends State<music> {
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

