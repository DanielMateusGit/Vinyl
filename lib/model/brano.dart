class Brano {
  final int id;
  final String nome;
  final String url;
  final String path;
  final int idPlaylist;
  Brano({ this.nome,
    this.id,
    this.url,
    this.path,
   this.idPlaylist
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'url': url,
      'path': path,
      'idPlaylist':idPlaylist
    };

  }
  @override
  String toString() {
    return 'Brano{id: $id, name: $nome';
  }

}