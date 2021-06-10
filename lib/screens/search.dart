import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vinylproject/model/Video.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // id per la navigazione + queries di ricerca
  static final String id = 'search_screen';
  List<Video> _Queries = [];
  String _Query;

  // metodo per richiedere video da youtube
  void fetchVideo() async {
    _Queries.clear();
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_Query&type=video&key=AIzaSyCBkLl_1dEmkxUEUdYJROlL9jMVDfBlCGY'));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      for (int i = 0; i < 5; i++) {
        _Queries.add(Video.fromJson(decodedData, i));
      }

      _Queries.reversed;

      setState(() {});
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search on YouTube',
            ),
            textInputAction: TextInputAction.go,
            onChanged: (value) {
              _Query = value;
            },
            onEditingComplete: fetchVideo,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _Queries.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: _Queries[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
