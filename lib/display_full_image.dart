import 'package:flutter/material.dart';
import 'package:flutter_test_app/GLOBAL_VARIABLES.dart' as local_var;

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
    Widget displayFullImage =
        Image.network(local_var.ref, fit: BoxFit.scaleDown);
    return new Scaffold(body: displayFullImage);
  }
}
