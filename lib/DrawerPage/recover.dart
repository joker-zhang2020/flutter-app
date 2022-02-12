import 'package:flutter/material.dart';

class Recover extends StatefulWidget {
  const Recover({Key? key}) : super(key: key);

  @override
  _RecoverState createState() => _RecoverState();
}

class _RecoverState extends State<Recover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(child: const Text('Recover'))
    );
  }
}
