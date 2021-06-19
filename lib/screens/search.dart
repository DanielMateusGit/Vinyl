import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vinylproject/constants.dart';
import 'package:vinylproject/model/brano.dart';
import 'package:vinylproject/model/youtube_query.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // id per la navigazione + queries di ricerca
  static final String id = 'search_screen';
  List<YoutubeQuery> _queries = [];
  bool _isLoading;
  String _query;

  @override
  void initState() {
    _isLoading = false;
  }

  // metodo per richiedere video da youtube
  void fetchVideo() async {
    _queries.clear();
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_query&type=video&key=AIzaSyCBkLl_1dEmkxUEUdYJROlL9jMVDfBlCGY'));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      for (int i = 0; i < 5; i++) {
        _queries.add(YoutubeQuery.fromJson(decodedData, i));
      }

      _queries.reversed;

      setState(() {
        _isLoading = false;
      });
    } else {
      throw Exception(response.body);
    }
  }

  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 25.0),
            child: Text('_Search', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
              fontSize: 18,
            ),),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search on YouTube',
                suffixIcon: _isLoading == false
                    ? null
                    : IconButton(
                        onPressed: () {
                          this.setState(() {
                            _textController.clear();
                            _isLoading = false;
                            _queries.clear();
                          });
                        },
                        icon: Icon(Icons.close, size: 20.0),
                      ),
              ),
              textInputAction: TextInputAction.go,
              onChanged: (value) {
                _query = value;
                setState(() {
                  if (_query.isEmpty) {
                    _queries.clear();
                    _isLoading = false;
                  } else {
                    _isLoading = true;
                  }
                });
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
            child: _isLoading
                ? Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: _queries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(),
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
