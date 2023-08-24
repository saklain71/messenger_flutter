import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  const ButtonCard({Key? key, required this.icon, required this.name}) : super(key: key);
  final IconData icon;
  final String name;

  @override
  State<ButtonCard> createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        child: Icon(
          widget.icon,
          size: 26,
          color: Colors.white,
        ),
      ),
      title: Text(
          widget.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
