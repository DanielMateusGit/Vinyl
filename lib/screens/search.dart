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
  List<Video> _queries = [];
  String _query;

  // metodo per richiedere video da youtube
  void fetchVideo() async {
    _queries.clear();
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_query&type=video&key=AIzaSyCBkLl_1dEmkxUEUdYJROlL9jMVDfBlCGY'));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      for (int i = 0; i < 5; i++) {
        _queries.add(Video.fromJson(decodedData, i));
      }

      _queries.reversed;

      setState(() {});
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0,bottom:15.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search on YouTube',
              ),
              textInputAction: TextInputAction.go,
              onChanged: (value) {
                _query = value;
              },
              onEditingComplete: () {
                fetchVideo();

                // Toglie il focus alla tastiera android
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
                },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _queries.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: _queries[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
