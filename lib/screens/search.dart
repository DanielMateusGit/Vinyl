import 'package:flutter/material.dart';

class Search extends StatefulWidget {

  static final String id = 'search_screen';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Search"),
    );
  }
}
