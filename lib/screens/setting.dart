
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:camera/camera.dart';
import 'package:stampshot/screens/Previewscreen.dart';

import 'package:flutter/services.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/src/rendering/object.dart';
//import 'package:torch_compat/torch_compat.dart';

var rig = TextEditingController(text: '10'); //가로 위치 입력 변수
var hei = TextEditingController(text: '80'); //세로 위치 입력 변수 100

double size = 80;

class setting extends StatefulWidget {
  @override
  settingState createState() => new settingState();
}

class settingState extends State<setting>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: new Text('Setting'),
            leading: Padding(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(null),
              ),
            ),
          ),
          body: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisCount: 1,
            mainAxisSpacing: 20,

            children: <Widget>[
              Container(
                height: 00,
                color: Colors.blueGrey,
                child: Container(width: 00, height: 00,
                    child:Column(
                      children: <Widget>[
                        Text('스탬프 위치 지정\n', style: TextStyle(fontSize: 30),),

                        TextField(controller: rig, decoration: InputDecoration(labelText: '가로 위치 입력(-17~285)', labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 5.0))),
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 17, color: Colors.white),keyboardType: TextInputType.number,
                        ),
                        TextField(controller: hei, decoration: InputDecoration(labelText: '세로 위치 입력(100~1320)', labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent, width: 5.0))),
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 17, color: Colors.white),keyboardType: TextInputType.number,),
                        Text('스탬프 위치를 나타낼곳을 선택하세요'),
                        // RaisedButton(onPressed: () => { Navigator.of(context).pop(null) }, color: Colors.lightGreenAccent, child: Text('위치 지정 완료'),),
                        Container(
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 7,
                            runSpacing: -5,
                            children: <Widget>[

                              new MaterialButton(minWidth: 100, onPressed: () {location1(context);}, child: Text('왼쪽상단'), color: Colors.white),
                              new MaterialButton(minWidth: 100, onPressed: () {location2(context);}, child: Text("가운데상단"), color: Colors.white,),
                              new MaterialButton(minWidth: 100, onPressed: () {location3(context);}, child: Text("오른쪽상단"), color: Colors.lightGreenAccent,),
                              new MaterialButton(minWidth: 100, onPressed: () {location4(context);},child: Text(" 왼쪽 "), color: Colors.white,),
                              new MaterialButton(minWidth: 100, onPressed: () {location5(context);}, child: Text('중앙', textAlign: TextAlign.center,), color: Colors.orangeAccent,),
                              new MaterialButton(minWidth: 100, onPressed: () {location6(context);}, child: Text(' 오른쪽 '), color: Colors.white,),
                              new MaterialButton(minWidth: 100, onPressed: () {location7(context);}, child: Text('왼쪽하단'), color: Colors.white,),
                              new MaterialButton(minWidth: 100, onPressed: () {location8(context);}, child: Text('가운데하단'), color: Colors.white,),
                              new MaterialButton(minWidth: 100, onPressed: () {location9(context);}, child: Text('오른쪽하단'), color: Colors.lime,),
                            ],
                          ),
                        )

                      ],
                    )
                ),
              ),
              Container( //스탬프 크기
                width: 100,height: 9999300,
                color: Colors.teal,
                child: Column(
                  children: <Widget>[
                    Text('스탬프 크기 조절', style: TextStyle(fontSize: 30)),
                    Text(' 슬라이드를 이용하여 크기를 조절하세요.\n', style: TextStyle(fontSize: 20),),
                    Container(child: new Image.asset('assets/images/stampsize.png'),),
                    Slider(
                      value: size,
                      min: 0,
                      max: 100,
                      divisions: 80,
                      activeColor: Colors.orangeAccent,
                      inactiveColor: Colors.white,
                      label: '현재 크기는: '+size.round().toString(),
                      onChanged: (double siz){
                        setState(() {
                          size = siz;
                          //size1=siz.roundToDouble();
                          print("현재사이즈 "+siz.toString());
                        });
                      },
                    ),
                    Text('현재 스탬프 크기는 ['+size.round().toString()+'] 입니다.', style: TextStyle(fontSize: 20),),

                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

//void send_value(BuildContext context) async{
//
//  final cameras = await availableCameras();
//  final firstCamera = cameras.first;
//
//  final na = Navigator.of(context);
//  await na.push(CupertinoPageRoute(builder: (context) =>
//  Cam(r_size: right_text,
//  camera: firstCamera,),)
//    ,);
//  print('오른쪽값:');
//  print(right_text);
//  print(ri);
//
//}

//왼쪽 상단
void location1 (BuildContext context){ //왼쪽상단
  rig = TextEditingController(text: "300");
  hei = TextEditingController(text: "100");
  Navigator.pop(context);
}

//중앙 상단
void location2 (BuildContext context){ //
  rig = TextEditingController(text: "155");
  hei = TextEditingController(text: "100");
  Navigator.pop(context);
}

//오른쪽 상단
void location3 (BuildContext context){
  rig = TextEditingController(text: "10");
  hei = TextEditingController(text: "80");
  Navigator.pop(context);
}

//왼쪽
void location4 (BuildContext context){
  rig = TextEditingController(text: "300");
  hei = TextEditingController(text: "650");
  Navigator.pop(context);
}

//중앙
void location5 (BuildContext context){
  rig = TextEditingController(text: "155");
  hei = TextEditingController(text: "650");
  Navigator.pop(context);
}

//오른쪽
void location6 (BuildContext context){
  rig = TextEditingController(text: "10");
  hei = TextEditingController(text: "650");
  Navigator.pop(context);
}

//왼쪽하단
void location7 (BuildContext context){
  rig = TextEditingController(text: "300");
  hei = TextEditingController(text: "1150");
  Navigator.pop(context);
}

//중앙하단
void location8 (BuildContext context){
  rig = TextEditingController(text: "155");
  hei = TextEditingController(text: "1300");
  Navigator.pop(context);
}

//오른쪽하단
void location9 (BuildContext context){
  rig = TextEditingController(text: "10");  //55
  hei = TextEditingController(text: "1300"); //1030
  Navigator.pop(context);
}