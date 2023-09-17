
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_flutter/Screens/CameraViewPage.dart';
import 'package:path/path.dart' show join;
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
  // CameraController? _cameraController;
  // Future<void>? cameraValue;

  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;
  //final CameraDescription camera = ApiCommon.firstCamera;

  // late XFile pictureFile;
  // late XFile imagePick;
  //
  // ImagePicker image = ImagePicker();

  //final cameras = Common.firstCamera;
  // late List<CameraDescription> _cameras;


  @override
  void initState() {
    super.initState();
    //_cameras = await availableCameras();
    //_cameraController = CameraController(cameras![0], ResolutionPreset.high);
    //cameraValue = _cameraController!.initialize();
    _initCamera();
  }
  void _initCamera() async {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras![0],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller!.initialize();

    //_cameras = await availableCameras();
    //_cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    //cameraValue =  _cameraController!.initialize();
    // cameraValue = _cameraController!.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;
  XFile? pickimage;
  String? loadImage;

  /// image picker function
  Future CameraImage() async{
    var photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1500,
      maxWidth: 1500,
    );
    setState(() {
      _image = File(photo!.path);
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
              path: _image.toString(),
            )));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_controller!));
                } else {
                  return const Center(
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
                                ? _controller!
                                .setFlashMode(FlashMode.torch)
                                : _controller!.setFlashMode(FlashMode.off);
                          }),
                      GestureDetector(
                        onLongPress: () async{
                          await _controller!.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async{
                          // final path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");
                          //
                          // XFile videopath =  await _cameraController!.stopVideoRecording();

                          XFile videopath =
                          await _controller!.stopVideoRecording();

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
                           //if(!isRecording) takePhoto(context);
                          CameraImage();
                           // Navigator.push(
                           //          context,
                           //          MaterialPageRoute(
                           //              builder: (builder) => CameraViewPage(
                           //                path: imagePick.toString(),
                           //              )));


                          //   await _initializeControllerFuture;
                          //   final image = await _controller!.takePicture();
                          //   if (!mounted) return;
                          //   print('image $image');
                          //    await Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (builder) => CameraViewPage(
                          //             path: image.path,
                          //           )));
                          // } catch (e) {
                          //   // If an error occurs, log the error to the console.
                          //   print("flutt $e");
                          // }


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
          // if (pictureFile != null)
          //   Image.network(
          //     pictureFile!.path,
          //     height: 200,
          //   )
        ],
      ),
    );
  }
  void takePhoto(BuildContext context) async {
    final picker = ImagePicker();
    print("path from takephoto");
     // final path = join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");

    final patH = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    // pictureFile = patH as XFile?;

    try {
        await _controller!.takePicture();
    } catch (e) {
      print("Error taking picture: $e");
    }


    // file.saveTo(path!);
    setState(() {});
    //print('path file $patH');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
              path: patH,
            )));
  }

  void _onCapturePressed(context) async {
    try {
      final path =
      join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _controller!.takePicture();

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
