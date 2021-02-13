import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test_app/GLOBAL_VARIABLES.dart' as local_var;

Future<List<Album>> fetchData() async {
  final response = await http.get('https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
  if (response.statusCode == 200) {
    return List<Album>.from(json.decode(response.body).map((x) => Album.fromJson(x)));
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Text', home: ShowList());
  }
}

class ShowList extends StatefulWidget {
  ShowList({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class DisplayFullImage extends StatefulWidget {
  DisplayFullImage() : super();

  @override
  State<StatefulWidget> createState() {
    return DisplayFullImageState();
  }
}

class DisplayFullImageState extends State<DisplayFullImage> {
  @override
  Widget build(BuildContext context) {
    Widget displayFullImage = Image.network(local_var.ref, fit: BoxFit.scaleDown);
    return new Scaffold(body: displayFullImage);
  }
}

class _MyAppState extends State<ShowList> {
  List<Album> _data;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    fetchData().then((data) {
      setState(() {
        _data = data;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_loading ? 'Loading...' : 'Data'),
        ),
        body: Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: _data == null ? 0 : _data.length,
                itemBuilder: (context, index) {
                  Album data = _data[index];
                  return ListTile(
                    onTap: () {
                      local_var.ref = data.largePhoto;
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DisplayFullImage();
                      }));
                    },
                    leading: Image.network(
                      data.photo,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: 50,
                    ),
                    title: Text(data.name == null ? "No Data" : data.name),
                  );
                })));
  }
}
