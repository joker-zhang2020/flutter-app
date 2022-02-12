import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('与你',style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text("相遇的第24天")
                ],
              ),
            ),
            SizedBox(height:100,child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: const [Text('已记录'),SizedBox(height: 2),Text('1')]),
                  Column(children: const [Text('文字'),SizedBox(height: 2),Text('96')]),
                  Column(children: const [Text('图片'),SizedBox(height: 2),Text('0')])
                ])),
            const SizedBox(height:50,child: Text('…… 年度回顾  ……')) ,
            const SizedBox(height: 100)
          ],
        )
    );
  }
}
