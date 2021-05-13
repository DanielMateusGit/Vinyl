import 'package:flutter/material.dart';
import 'package:vinyl/componenti/barra_navigazione.dart';

class podcast extends StatefulWidget {
  @override
  _podcastState createState() => _podcastState();
}

class _podcastState extends State<podcast> {
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

