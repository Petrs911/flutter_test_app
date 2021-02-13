import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchData() async {
  final response = await http.get(
      'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
  if (response.statusCode == 200) {
    return List<Album>.from(
        json.decode(response.body).map((x) => Album.fromJson(x)));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  String photo;
  String name;
  String largePhoto;

  Album({this.photo, this.name, this.largePhoto});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      photo: json['urls']['small'],
      name: json['user']['name'],
      largePhoto: json['urls']['full'],
    );
  }
}
