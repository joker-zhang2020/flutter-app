import 'package:flutter/material.dart';

class Split extends StatefulWidget {
  const Split({Key? key}) : super(key: key);

  @override
  _SplitState createState() => _SplitState();
}

class _SplitState extends State<Split> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text('分类')),
        body: Container(child: const Text('split'))
    );
  }
}
