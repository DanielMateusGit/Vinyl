import 'package:flutter/material.dart';
import 'package:vinylproject/constants.dart';
class Playlist extends StatelessWidget{
  final int id;
  final String nome;
  final String sottotitolo;
  final int tipo;

  Playlist({ this.nome,
    this.id,
    this.tipo,
    this.sottotitolo
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      "sottotitolo":sottotitolo,
      'tipo': tipo,
    };

  }

  /*String toString() {
    return 'Playlist{id: $id, name: $nome}';
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.all(4.0),
      child:

        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              new Container(
                child:
                new Padding(
                  child:
                  new Image.network(
                    'https://static2-viaggi.corriereobjects.it/wp-content/uploads/2019/11/1-1.jpg?v=353239',
                    fit:BoxFit.fill,
                    width: 100.0,
                    height: 100.0,
                  ),

                  padding: const EdgeInsets.all(4.0),
                ),

                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.centerLeft,
                width: 50.0,
                height: 50.0,
              ),

              new Expanded(

                child:
                    Padding (
                      padding:const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child:
                new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        nome,
                        style: new TextStyle(fontSize:12.0,
                            color: const Color(0xFFffffff),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto"),
                      ),

                      new Text(
                        sottotitolo,
                        style: new TextStyle(fontSize:12.0,
                            color: const Color(0xFFffffff),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      )
                    ]
                ),
                ),


              ),

              new Container(
                child:
                new Icon(
                    Icons.more_vert,
                    color: const Color(0xFFffffff),
                    size: 24.0),

                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.centerRight,
                width: 50.0,
                height: 50.0,
              )
            ]
        )
        );


  }

}