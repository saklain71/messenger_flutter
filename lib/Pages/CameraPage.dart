import 'package:flutter/material.dart';
import 'package:messenger_flutter/Screens/CameraScreen.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key, required this.onImageSend}) : super(key: key);
  final Function onImageSend;
  @override
  Widget build(BuildContext context) {
    return CameraScreen(
      onImageSend: onImageSend,);
  }
}
