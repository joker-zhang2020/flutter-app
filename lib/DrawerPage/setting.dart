import 'package:flutter/material.dart';
import 'package:init/icons/myIcons.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<Map<String, dynamic>> setting = [{
    "icon":const Icon(Icons.account_circle),"title":"账号信息","action":const Text('登录')
  },{
    "icon":const Icon(MyIcons.ring),"title":"提醒","action":null
  },{
    "icon":const Icon(Icons.nightlight_round),"title":"夜间","action":null,
  },{
    "icon":const Icon(Icons.font_download),"title":"样式","action":null,
  },{
    "icon":const Icon(MyIcons.pen),"title":"编辑","action":null,
  },{
    "icon":const Icon(Icons.text_format),"title":"日记字体","action":null,
  },{
    "icon":const Icon(Icons.workspaces_outline),"title":"往年今日","action":null,
  },{
    "icon":const Icon(MyIcons.lock),"title":"应用密码","action":null,
  },{
    "icon":const Icon(MyIcons.cloud),"title":"同步选项","action":null,
  },{
    "icon":const Icon(MyIcons.pdf),"title":"导入导出","action":null,
  },{
    "icon":const Icon(MyIcons.warning),"title":"关于","action":null,
  },{
    "icon":const Icon(Icons.favorite),"title":"好评鼓励","action":null,
  },{
    "icon":const Icon(MyIcons.earth),"title":"网页版","action":null
  },{
    "icon":const Icon(MyIcons.restart),"title":"重启应用","action":null,
  }];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('设置')),
        body: ListView(
          children: setting.map((item){
              return ListTile(
                leading: item['icon'],
                title: Text(item['title']),
              );
          }).toList(),
        )
    );
  }
}
