import 'package:flutter/material.dart';
import 'components/navigation_bar.dart';

void main() => runApp(Vinyl());

class Vinyl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        bottomNavigationBar: new NavigationBar(),
      ),
      theme: new ThemeData.dark(),
    );
  }
}
