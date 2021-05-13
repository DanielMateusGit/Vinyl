
import 'package:flutter/material.dart';
import 'package:vinyl/componenti/barra_navigazione.dart';

class downloads extends StatefulWidget {
  @override
  _downloadsState createState() => _downloadsState();
}

class _downloadsState extends State<downloads> {
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

