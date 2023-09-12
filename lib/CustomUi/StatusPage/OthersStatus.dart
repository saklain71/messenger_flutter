import 'dart:math';
import 'package:flutter/material.dart';

class OthersStatus extends StatefulWidget {
   OthersStatus({Key? key , required this.name, required this.imageName, required this.time, this.isSeen, this.statusNum}) : super(key: key);
   final  name;
   final  imageName;
   final  time;
   final  isSeen;
   final  statusNum;

  @override
  State<OthersStatus> createState() => _OthersStatusState();
}

class _OthersStatusState extends State<OthersStatus> {

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: CustomPaint(
        painter: StatusPainter(isSeen: widget.isSeen, statusNum: widget.statusNum),
        child: CircleAvatar(
          radius: 27,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(widget.imageName),
        ),
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

degreeToAngle(double degree){
  return degree * pi/180;
}

class StatusPainter extends CustomPainter{
  bool isSeen;
  int statusNum;
  StatusPainter({required this.isSeen, required this.statusNum});


  //StatusPainter({Key? key , required.this.isSeen, required.this.statusNum});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = 6.0
        ..color = const Color(0xff21bfa6)
        ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }
  void drawArc(Canvas canvas, Size size, Paint paint){
    if(statusNum== 1){
      canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngle(0), degreeToAngle(360), false, paint);
    }else{
      double degree = -90;
      double arc = 360;
      for(int i = 0; i<statusNum; i++){
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            degreeToAngle(degree + 4), degreeToAngle(arc - 8), false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}