import 'package:flutter/material.dart';
import 'package:init/icons/myIcons.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: const [
          Icon(Icons.share),
          SizedBox(width: 10),
          Icon(Icons.copy),
          SizedBox(width: 10),
          Icon(Icons.more_vert)
        ]),
        body:const Text('123'),
        floatingActionButton: FloatingActionButton(child: const Icon(MyIcons.pen),
          onPressed: () {  }
          ));
  }
}
