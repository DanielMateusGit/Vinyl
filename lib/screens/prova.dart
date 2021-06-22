import 'package:flutter/material.dart';
import 'package:vinylproject/screens//download.dart';

class Prova extends StatelessWidget{
  final String name;

  const Prova({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      children: [
        Text('hello $name'),
      ],
    ),
  );


}