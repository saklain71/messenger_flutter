import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.message, required this.time}) : super(key: key);
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Card(
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
                right: 10,
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
