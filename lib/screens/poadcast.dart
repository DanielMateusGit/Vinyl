import 'package:flutter/material.dart';

class Poadcast extends StatefulWidget {

  static final String id = 'poadcast_screen';

  @override
  _PoadcastState createState() => _PoadcastState();
}

class _PoadcastState extends State<Poadcast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Poadcast'),
    );
  }
}
