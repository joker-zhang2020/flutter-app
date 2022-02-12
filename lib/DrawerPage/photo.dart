import 'package:flutter/material.dart';

class Photo extends StatefulWidget {
  const Photo({Key? key}) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text('图库')),
        body: Container(child: const Text('photo'))
    );
  }
}
