import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:messenger_flutter/Common/Coomon.dart';
import 'package:messenger_flutter/Screens/CameraViewPage.dart';
// import 'package:path/path.dart' show join;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'VideoView.dart';

 List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  // final CameraDescription camera;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  //final cameras = Common.firstCamera;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    //_cameras = await availableCameras();
    //_cameraController = CameraController(cameras![0], ResolutionPreset.high);
    //cameraValue = _cameraController!.initialize();
    _initCamera();
  }
  void _initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    cameraValue =  _cameraController!.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController!));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              width: MediaQuery.of(context).size.width,
              color: Colors.black54,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController!
                                .setFlashMode(FlashMode.torch)
                                : _cameraController!.setFlashMode(FlashMode.off);
                          }),
                      GestureDetector(
                        onLongPress: () async{
                          await _cameraController!.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async{
                          // final path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");
                          //
                          // XFile videopath =  await _cameraController!.stopVideoRecording();

                          XFile videopath =
                          await _cameraController!.stopVideoRecording();

                          setState(() {
                            isRecording = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VideoViewPage(
                                    path: videopath.path,
                                  )));
                        },
                        onTap: () async {
                          print("path empty");
                           if(!isRecording) takePhoto(context);

                           //final path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (builder) => CameraViewPage(
                          //           path: path,
                          //         )));
                        },
                        child: isRecording
                            ? Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 80,)
                            : Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,),
                      ),
                      IconButton(
                        icon: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                          size: 28,
                        ), onPressed: () {
                          setState(() {

                          });
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Hold for Video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
  void takePhoto(BuildContext context) async {
    print("path from takephoto");
     String path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");
      //String? path;
      XFile file = await _cameraController!.takePicture();
     // file.saveTo(path!);
     print('path last $path');
     print('path file $file');


    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (builder) => CameraViewPage(
    //           path: file.path,
    //         )));
  }
  void _onCapturePressed(context) async {
    try {
      final path =
      join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _cameraController!.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraViewPage(
              path: path,
            )),
      );
    } catch (e) {
      //_showCameraException(e);
    }
  }


}
