import 'dart:io';
import 'package:flutter/material.dart';
class OwnFileCard extends StatelessWidget {
  const OwnFileCard({Key? key, required this.path, required this.message, required this.time}) : super(key: key);
  final String path;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height /2.5,
          width: MediaQuery.of(context).size.width /2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.green[300]
          ),
          child: Card(
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Image.file(
                  File(path),
                  fit: BoxFit.fitHeight,
                ),
                Text(message.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
