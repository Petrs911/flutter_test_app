import 'package:flutter/material.dart';
import 'package:flutter_test_app/GLOBAL_VARIABLES.dart' as local_var;
import 'package:flutter_test_app/get_data.dart';
import 'package:flutter_test_app/display_full_image.dart';

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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
