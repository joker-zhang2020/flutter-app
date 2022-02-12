import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init/DrawerPage/classify.dart';
import 'package:init/DrawerPage/color.dart';
import 'package:init/DrawerPage/photo.dart';
import 'package:init/DrawerPage/recover.dart';
import 'package:init/DrawerPage/setting.dart';
import 'package:init/DrawerPage/split.dart';
import 'package:init/DrawerPage/statistics.dart';
import 'package:init/DrawerPage/suggestion.dart';
import 'package:init/editPage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'CreateDairy/diary.dart';
import 'icons/myIcons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CreateDairy()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Color(0xFF708090),
        child: UserInformation(),
      ),
      appBar: const TopBar(),
      backgroundColor: const Color(0xFF2F4F4F),
      body: const DiaryListPage(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2F4F4F),
        onPressed: _incrementCounter,
        child: const Icon(MyIcons.pencil),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DiaryListPage extends StatefulWidget {
  const DiaryListPage({Key? key}) : super(key: key);

  @override
  _DiaryListPageState createState() => _DiaryListPageState();
}

class _DiaryListPageState extends State<DiaryListPage> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to load more");
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (c, i) {
          if (i == 0) {
            return Container(
              child: const Text(
                '连续记录 0 天 (共 6 篇)',
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            );
          } else if (i == 1) {
            return InkWell(child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: const [
                      Text('07', style: TextStyle(fontSize: 20.0)),
                      Text('2月/周一'),
                      Text('未同步', style: TextStyle(color: Colors.amber))
                    ]),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Container 的圆角边框",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 10),
                            Text(
                              '20:44',
                              style: TextStyle(fontSize: 12),
                            )
                          ]),
                    ),
                  ],
                )),onTap: (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const EditPage()));
            },);
          }
          return InkWell(child:  Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: const [
                    Text('未同步', style: TextStyle(color: Colors.amber)),
                    Text('           ', style: TextStyle(fontSize: 20.0)),
                  ]),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8),
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Container 的圆角边框",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text(
                            '20:44',
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                  ),
                ],
              )),onTap: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const EditPage()));
          },);
        },
        itemCount: items.length,
      ),
    );
  }
}



class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  List<Map<String, dynamic>> list = [
    {"icon": const Icon(MyIcons.statistics), "text": "统计","onTap":const Statistics()},
    {"icon": const Icon(MyIcons.photo), "text": "图库","onTap":const Photo()},
    {"icon": const Icon(MyIcons.classify), "text": "分类","onTap":const Classify()},
    {"icon": const Icon(MyIcons.split), "text": "漫步","onTap":const Split()},
    {"icon": const Icon(MyIcons.night), "text": "夜间"},
    {"icon": const Icon(MyIcons.color), "text": "主题","onTap":const ColorPage()},
    {"icon": const Icon(MyIcons.setting), "text": "设置","onTap":const Setting()},
    {"icon": const Icon(MyIcons.recover), "text": "回收","onTap":const Recover()},
    {"icon": const Icon(MyIcons.suggestion), "text": "反馈","onTap":const Suggestion()}
  ];
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("fonts/icon/balloon.png"),
                fit: BoxFit.fitHeight),
            color: Color(0xFF708090),
          ),
          child: Text(
            '账号信息',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ...list.map((item) {
          if (item["text"] == "夜间") {
            return ListTile(
              leading: item["icon"],
              title: Text(item["text"]),
              trailing: Switch(
                value: dark,
                onChanged: (bool value) {
                  setState(() {
                    dark = !dark;
                  });
                },
              ),
            );
          }
          return InkWell( child:  ListTile(
            leading: item["icon"],
            title: Text(item["text"]),
          ),onTap:(){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => item['onTap']));});
        }).toList()
      ],
    );
  }
}

class TopBar extends StatefulWidget with PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> {
  String? selectedValue;
  bool isOpen = false;
  List<String> items = [
    'Item11123123123',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: isOpen
          ? Container(
              margin: const EdgeInsets.fromLTRB(0, 56, 0, 0),
              height: 500,
              child: SfCalendar(
                  view: CalendarView.workWeek,
                  timeSlotViewSettings: const TimeSlotViewSettings(
                      startHour: 9,
                      endHour: 16,
                      nonWorkingDays: <int>[
                        DateTime.friday,
                        DateTime.saturday
                      ])))
          : null,
      backgroundColor: const Color(0xFF2F4F4F),
      title: DropdownButton2(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonHeight: 40,
        buttonWidth: 140,
      ),
      actions: [
        Container(
            child: const Icon(MyIcons.search),
            padding: const EdgeInsets.all(10.0)),
        Container(
            child: const Icon(MyIcons.tag),
            padding: const EdgeInsets.all(10.0)),
        PopupMenuButton(
          color: Colors.black,
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text("云同步"),
              ),
              const PopupMenuItem(
                child: Text("按时间顺序"),
              ),
              const PopupMenuItem(
                child: Text("显示隐藏日记"),
              ),
              const PopupMenuItem(
                child: Text("打码日记内容"),
              ),
              const PopupMenuItem(
                child: Text("切换首页模板"),
              ),
            ];
          },
        ),
      ],
    );
  }
}
