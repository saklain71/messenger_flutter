import 'package:flutter/material.dart';

class OthersStatus extends StatefulWidget {
   OthersStatus({Key? key , required this.name, required this.imageName, required this.time}) : super(key: key);
   final  name;
   final  imageName;
   final  time;

  @override
  State<OthersStatus> createState() => _OthersStatusState();
}

class _OthersStatusState extends State<OthersStatus> {

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: CircleAvatar(
        radius: 27,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(widget.imageName),
      ),
      title: Text(
        widget.name,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      ),
      subtitle: Text(
        "Today at ${widget.time}",
        style: TextStyle(
            fontSize: 17,
            color: Colors.grey
        ),
      ),
    );
  }
}
