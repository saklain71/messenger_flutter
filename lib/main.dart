import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:messenger_flutter/Common/Coomon.dart';
import 'Screens/CameraScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Group/home_to_group_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   cameras = await availableCameras();
  //ApiCommon.firstCamera = cameras.first;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "OpenSans",
          primaryColor: Color(0xFF075E54),
          hintColor: Color(0xFF128C7E)),
      // home: LoginScreen(),
      home: const HomeToGroup(),
    );
  }
}

