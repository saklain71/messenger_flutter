import 'dart:io';
import 'package:flutter/material.dart';
class ReplyFileCard extends StatelessWidget {
  const ReplyFileCard({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height /2.5,
          width: MediaQuery.of(context).size.width /2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[400]
          ),
          child: Card(
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Image.file(File(path)),
          ),
        ),
      ),
    );
  }
}
