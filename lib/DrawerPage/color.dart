import 'package:flutter/material.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({Key? key}) : super(key: key);

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  bool lightTheme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('主题'),
            actions: [
              InkWell(
                child: Center(child: lightTheme ? const Text('夜间主题') : const Text("日间主题")),
                onTap: (){
                  setState(() {
                    lightTheme = !lightTheme;
                  });
                },
              ),
              const SizedBox(width: 10)]
        ),
        body: Container(child: const Text('color'))
    );
  }
}
