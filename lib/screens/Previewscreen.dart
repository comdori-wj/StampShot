import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:stampshot/screens/setting.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:ext_storage/ext_storage.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';




class Previewscreen extends StatelessWidget {


  Previewscreen({this.imagePath, @required this.stamp, this.right, this.height, this.size});

  //_Mainpage(BuildContext context) => Navigator.pop(null);  //메인페이지로 이동하는 클래스 push-새로운 화면, pop-이전 화면 복귀

  final imagePath;
  final right;
  final height;
  final size; //스탬프 이미지 크기
  File stamp;

  GlobalKey global = GlobalKey();
  BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;


    double auto_width = MediaQuery.of(context).size.width;
    double height1 = MediaQuery.of(context).size.height;
    var pad = MediaQuery.of(context).padding;
    double height2 = height1-pad.top-pad.bottom;
    double height3 = height1-pad.bottom+500;
    double height4 = height1-pad.top-kToolbarHeight-50;

    double a = 50; // 스탬프 가로 위치
    double b = 100; // 스탬프 세로 위치
    Offset offset = Offset.zero;



    return Scaffold(
      appBar: AppBar(title: Text('사진 미리보기')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진 경로로 `Image.file`을 생성하세요.
      body: Center(

        child: Column(
            children: <Widget>[

              Container(),
              RepaintBoundary(
                  key: global,
                  child: new Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(width: auto_width, height: height4,  child: Image.file(File(imagePath)),padding: EdgeInsets.all(3),), //사진
                      Positioned(/* Positioned */
                        child: stamp == null
                        ? new Image.asset('assets/images/goodjob.png')
                        : new Image.file(stamp),  // Positioned(child: Image.asset('assets/images/kakao.jpg', width: 100),
                        width:  size, //max size 80  double.parse(size)
                        left: null,
                        right: right == null //스탬프 가로 위치 좌표
                            ? null
                            : double.parse(rig.text),//
                        height: height == null // 스탬프 세로 위치 좌표
                            ? null
                            : double.parse(hei.text),  //double.parse(hei.text) ,q9 기준 1310 1320

                      ),

                      //            Draggable(child:
                      //                Container(child:
                      //                stamp == null
                      //                ? new Image.asset('assets/images/goodjob.png')
                      //                : new Image.file(stamp),
                      //                width: 50,
                      //
                      //                height: double.parse(hei.text),), //Container(child: Image.asset('assets/images/py.png'), width: 90,)
                      //              feedback:Positioned(child:
                      //              stamp == null
                      //                  ? new Image.asset('assets/images/goodjob.png')
                      //                  : new Image.file(stamp),
                      //              width: 50,
                      //              right: double.parse(rig.text),
                      //              height: double.parse(hei.text),),
                      //              childWhenDragging: Container(),
                      //
                      //   onDragEnd: (details) {
                      //    (() {
                      // final adjustment = MediaQuery.of(context).size.height ;
                      // offset = Offset(details.offset.dx, details.offset.dy - adjustment);
                      //     });
                      //            }
                      //
                      //            ),//요기까지

                    ],)),
              // Container(width: 399.9, child: Image.file(File(imagePath)),  ),
              //CircleAvatar(radius: 50.0, backgroundColor: Colors.<em>red</em>,),
              //Container(height: 0),
              Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(onPressed: _takeshot,
                      child: Text('사진저장'),
                    ),
                    RaisedButton(child: Text('다시 사진촬영'), onPressed: () { Navigator.pop(context); //뒤로가기
                    }),
                    // RaisedButton(child: Text('공유하기'), onPressed: null)
                  ]),
                height:50,
              ),
              Container(child: null),
              // Container(width:100,child: RaisedButton(onPressed: () {}, child: Text('back'),))
            ]
        ),

      ),
      resizeToAvoidBottomInset: false,

    );

  }



  void _takeshot() async {
    /*var renderObject = global.currentContext.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;*/ //이걸써도 되고 아니면 아래 구문을 써도 좋다.

    try {
      RenderRepaintBoundary boundary = global.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 4.0); //캡쳐 화질 설정 pixeratio
      var directory = await ExtStorage.getExternalStorageDirectory();
      var stampshot = await new Directory('${directory}/StampShot').create(
          recursive: false);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File imgFile = new File('${stampshot.path}/${DateTime.now()}-StampShot.png');
      imgFile.writeAsBytes(pngBytes);
      Fluttertoast.showToast(
          msg: "사진은 갤러리 및 사진앱에서 확인하거나 \n ${directory}/StampShot에서 확인가능 합니다.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 17.0);
      print("캡쳐 완료 ${stampshot.path}");


    }
    catch(e)  {
      print("저장실패:"+e);
      Fluttertoast.showToast(
          msg: '사진저장을 하지 못하였습니다. \n 저장용량 액세스 권한이 허용 되었는지 확인하세요. \n$e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.deepOrangeAccent,
          textColor: Colors.white,
          fontSize: 17);
    }
  }
}