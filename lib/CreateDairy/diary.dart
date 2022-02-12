import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info/device_info.dart';
import '../icons/myIcons.dart';

class CreateDairy extends StatefulWidget {
  const CreateDairy({Key? key}) : super(key: key);

  @override
  _CreateDairyState createState() => _CreateDairyState();
}

class _CreateDairyState extends State<CreateDairy> {
  bool textIsChecked = false;
  bool markdownIsChecked = false;
  bool dairyVisibleIsChecked = false;
  DateTime today = DateTime.now();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var _imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(MyIcons.delete),
          ),
          backgroundColor: const Color(0xFF2F4F4F),
          title: Text.rich(TextSpan(children: [
            TextSpan(
                style: const TextStyle(fontSize: 20),
                text:
                    "${today.month.toString().padLeft(2, '0')}月${today.day.toString().padLeft(2, '0')}日"),
            TextSpan(
                style: const TextStyle(fontSize: 15),
                text:
                    " / ${today.hour.toString()}:${today.minute.toString()} 今天")
          ])),
          actions: [
            Container(
                child: const Icon(MyIcons.tag),
                padding: const EdgeInsets.all(10.0)),
            PopupMenuButton(
              color: Colors.black87,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        textIsChecked = !textIsChecked;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text("标题"),
                        Checkbox(
                          checkColor: Colors.white,
                          value: textIsChecked,
                          onChanged: (bool? value) {},
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        markdownIsChecked = !markdownIsChecked;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text("Markdown"),
                        Checkbox(
                          checkColor: Colors.white,
                          value: markdownIsChecked,
                          onChanged: (bool? value) {},
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      setState(() {
                        dairyVisibleIsChecked = !dairyVisibleIsChecked;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text("显示隐藏日记"),
                        Checkbox(
                          checkColor: Colors.white,
                          value: dairyVisibleIsChecked,
                          onChanged: (bool? value) {},
                        )
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text("隐藏日记"),
                  ),
                  const PopupMenuItem(
                    child: Text("日记模板"),
                  ),
                  const PopupMenuItem(
                    child: Text("上次编辑"),
                  ),
                  const PopupMenuItem(
                    child: Text("放弃编辑"),
                  ),
                ];
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2F4F4F),
        body: FutureBuilder<AndroidDeviceInfo>(
          future: deviceInfo.androidInfo,
          builder: (context, snapshot){
            return Container(
                margin: const EdgeInsets.all(10),
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const TextField(maxLines: 20, minLines: 5),
                  InkWell(
                      onTap: () async {
                        var image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          _imgPath = image;
                        });
                      }
                      ,child: Container(
                    margin:const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: _ImageView(_imgPath) ,
                  )),
                  Row(children: const [Icon(Icons.wb_sunny_outlined,size: 16),SizedBox(width: 10),Text("点击选择天气")]),
                  const SizedBox(height: 10),
                  Row(children: [const Icon(Icons.add_location_rounded,size: 16),const SizedBox(width: 10),
                    FutureBuilder<Position>(future:_determinePosition() ,builder: (context, snapshot) {
                      return Text(snapshot.connectionState == ConnectionState.done ? snapshot.data!.latitude.toString() : "定位失败，请检查系统定位是否已开启");
                    }),
                  ]),
                  const SizedBox(height: 10,),
                  Row(children: [const Icon(Icons.phone_android,size:16),const SizedBox(width: 10),Text(snapshot.connectionState == ConnectionState.done ? snapshot.data!.model : '')]),
                  const SizedBox(height:10),
                  Row(children: const [Icon(Icons.text_fields,size:16),SizedBox(width: 10),Text("1 字")],)
                ]));
          },
        ) );
  }

  Widget _ImageView(imgPath){
    if(imgPath == null){
      return const Icon(Icons.add);
    }else{
      return Image.file(File(imgPath.path));
    }
  }
  final ImagePicker _picker = ImagePicker();
  _takePhoto() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imgPath = image;
    });
  }

  _openGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
