import 'package:flutter/material.dart';
import '../icons/myIcons.dart';

class Classify extends StatefulWidget {
  const Classify({Key? key}) : super(key: key);

  @override
  _ClassifyState createState() => _ClassifyState();
}

class _ClassifyState extends State<Classify> {
  bool gridCut = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title:const Text('分类'),actions: [
          Container(
              child: const Icon(MyIcons.search),
              padding: const EdgeInsets.all(10.0)),
          InkWell(child: Container(
              child: gridCut ? const Icon(MyIcons.fourGrid) : const Icon(MyIcons.nineGrid),
              padding: const EdgeInsets.all(10.0)),onTap: (){
            setState(() {
              gridCut = !gridCut;
            });
          }),
        ]),
        body: Container(child: const Text('classify')),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        child: const Icon(Icons.add)),
    );
  }
}
