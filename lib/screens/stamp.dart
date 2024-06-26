import 'dart:io';
import 'dart:async' show Future;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:camera/camera.dart';
//import 'package:flutter_better_camera/camera.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:stampshot/screens/camera.dart';

import 'package:flutter/src/rendering/object.dart';

import 'package:flutter/services.dart' show rootBundle;

class Stamp extends  StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING = "PREFERENCES_IS_FIRST_LAUNCH_STRING";
  @override
  _StampPageState createState() => new _StampPageState();

}

class _StampPageState extends State<Stamp> {

  File _image; //이미지 불러오는 변수
  GlobalKey explan1 = GlobalKey(); //앱 사용설명 변수1
  GlobalKey explan2 = GlobalKey(); //앱 사용설명 변수2
  BuildContext myCon;


  // static const _adUnitID = "ca-app-pub-7875242624363574/6244191252";
  // final _nativeAdController = NativeAdmobController();
  // //final _nativeAdmob = NativeAdmob();


  Future getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null){
      print('위치'+image.path);

      //final String path = await getApplicationDocumentsDirectory().path;
      setState(() {
        _image = image;
      });

      /* final na = Navigator.of(context);
      await na.push(MaterialPageRoute(
          builder: (context) => MyAPP(stamp: image.path)));*/
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) =>
    { //한번만 보여주고 반복되지 않음
      _explan().then((result) {
        if (result)
          ShowCaseWidget.of(myCon).startShowCase([explan1, explan2]);
      })
    });
    _checkPermissions(); //사용자 권환 확인하기.
    //admob.init(); //광고

  }

  //권환확인 힘수.
  _checkPermissions() async{
    if (Platform.isAndroid){
      if (await Permission.storage.request().isGranted){
        await Permission.camera.request().isGranted;
        await Permission.microphone.request().isGranted;
      }
      Map<Permission, PermissionStatus> statuses = await[
        Permission.storage, Permission.camera, Permission.microphone
      ].request();
      print(statuses[Permission.storage]);
    }
  }



  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(builder: (context) {
        myCon = context;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ]); //화면 고정-세로 및 아래
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('★스탬프 사진 불러오기★'),
            backgroundColor: Colors.green,
            actions: <Widget>[
              Showcase(
                key: explan1,
                description: '\n스탬프 이미지를 선택 후 터치해주세요. \n선택하지 않았을 경우 임시 스탬프 이미지가 넣어집니다.',
                child: new IconButton(icon: new Icon(Icons.done_outline), onPressed: _save, tooltip: '이미지 선택이 완료되면 터치하세요.',),
              )
//            new IconButton(icon: new Icon(Icons.done_outline),
//              onPressed: _save,
//              tooltip: "이미지 선택이 완료 되면 터치하세요.",)
            ], centerTitle: true,
          ),

          body: new Center(
            child: new Column(
              children: <Widget>[

                Container(
                  child: _image == null
                      ? new Text(
                    '\n스탬프로 찍을 사진을 불러와주세요. \n사진이 넣어졌다면 왼쪽 상단 체크 표시를 터치하세요.',
                    style: TextStyle(fontSize: 27, color: Colors.cyan),)
                      : new Image.file(_image), width: 480, height: 400.0,


                ),
                new Container(height: 3,),
//                new CupertinoButton(onPressed: getImage,
//                  child: new Icon(Icons.add_photo_alternate),
//                  color: Colors.blueGrey,),
//            new CupertinoButton(child: new Icon(Icons.accessibility), onPressed: null),
                Showcase(
                  key: explan2,
                  title: "    이미지 선택 버튼",
                  description: '\n버튼을 터치하여 불러올 이미지를 넣어주세요.',
                  shapeBorder: CircleBorder(),
                  showcaseBackgroundColor: Colors.lightGreen,
                  child: CupertinoButton(
                    child: new Icon(Icons.add_photo_alternate),
                    color: Colors.lightBlue,
                    onPressed: getImage,
                  ),
                ),
                new Container(height: 3,),
                // new Container(child: NativeAdmob(
                //   adUnitID: _adUnitID,
                //   controller: _nativeAdController,
                //   type: NativeAdmobType.banner,
                // ),
                //   height: 70,
                // ),



//            new Text('예제 스탬프'),
//            new Container(
//
//              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
//              height: 150,
//
//              child: new ListView(
//                shrinkWrap: false,
//                scrollDirection: Axis.horizontal,
//                children: <Widget>[
//                  CupertinoButton(
//                    onPressed: _stamp1,
//                    child: new Image.asset('assets/images/py.png'),
//                    minSize: 0,
//                    color: Colors.white,
//
//                  ),
//                  MaterialButton(
//                    child: new Image.asset('assets/images/goodjob.png'),
//                    onPressed: () {},
//                    color: Colors.lightGreen,
//                  ),
//                  Container(
//                    width: 100,
//                    color: Colors.white,
//                  ),
//                  Container(
//                    width: 100,
//                    color: Colors.orange,
//                  ),
//                  Container(
//                    width: 100,
//                    color: Colors.lightGreen,
//                  )
//                ],
//              ),
//            )
              ],

            ),


          ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: getImage,
//        tooltip: 'Pick Image',
//        child: new Icon(Icons.photo_size_select_large),
//      ),
        );
      },),
    );
  }

  Future<bool> _explan() async{
    final  sharedPreferences = await SharedPreferences.getInstance();
    bool explan = sharedPreferences.getBool(Stamp.PREFERENCES_IS_FIRST_LAUNCH_STRING) ?? true ;
    if(explan)
      sharedPreferences.setBool(Stamp.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);
    return explan;
  }

  void _save() async {
    WidgetsFlutterBinding.ensureInitialized();

    final cameras = await availableCameras();  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
    final firstCamera = cameras.first; // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.

    final na = Navigator.of(context);

    // File pi = image;// await ImagePicker.pickImage(source: ImageSource.gallery);


    await na.push(MaterialPageRoute(
        builder: (context) => Camera(
          stamp2: _image,
          camera: firstCamera,

        )));

  }
  void _stamp1() async {



    WidgetsFlutterBinding.ensureInitialized();

    final cameras = await availableCameras();  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
    final firstCamera = cameras.first; // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.

    final na = Navigator.of(context);

    //File a1 = await getImageFileFromAssets('assets/images/py.png');
    // File pi = image;// await ImagePicker.pickImage(source: ImageSource.gallery);


    await na.push(MaterialPageRoute(
        builder: (context)=> Camera(
          stamp2: ImagePicker.pickImage(source: ImageSource.gallery),//getImageFileFromAssets('assets/images/py.png'),
          camera: firstCamera,

        )));

  }
}



