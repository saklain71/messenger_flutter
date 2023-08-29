import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:messenger_flutter/Common/Coomon.dart';
import 'package:messenger_flutter/Screens/CameraViewPage.dart';
// import 'package:path/path.dart' show join;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
  //final cameras = Common.firstCamera;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController!.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController!.dispose();
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
                          // await _cameraController!.startVideoRecording();
                          // setState(() {
                          //   isRecording = true;
                          // });
                        },
                        onLongPressUp: () async{
                          // final path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");
                          //
                          // XFile videopath =  await _cameraController!.stopVideoRecording();

                          setState(() {
                            isRecording = false;
                          });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (builder) =>
                                Container(color: Colors.red,)
                                ));
                        },
                        onTap: () async {
                           //if(!isRecording) takePhoto(context);
                           //final path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");

                          try {
                            // Ensure that the camera is initialized.
                            print('image');
                            await cameraValue;

                            // Attempt to take a picture and then get the location
                            // where the image file is saved.
                            final image = await _cameraController!.takePicture();
                            print('image $image');
                            _cameraController!.dispose();
                          } catch (e) {
                            // If an error occurs, log the error to the console.
                            print("error $e");
                          }

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
    // final path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");

     XFile path = await _cameraController!.takePicture();
     print('path $path');

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
