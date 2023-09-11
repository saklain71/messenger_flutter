import 'package:flutter/material.dart';
import 'package:messenger_flutter/CustomUi/StatusPage/HeadOwnStatus.dart';
import 'package:messenger_flutter/CustomUi/StatusPage/OthersStatus.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
               child: Icon(
                   Icons.edit,
                   color: Colors.blueGrey[900],
               ),
               onPressed: () {  },
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.greenAccent[100],
              child: Icon(
                Icons.camera_alt,
                color: Colors.blue,
              ),
              onPressed: () {  },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          HeadOwnStatus(),
          Level("Recent Updates"),
          OthersStatus(
              name : "Sami",
              imageName: "assets/3.jpg",
              time : "12:00 am"
          ),
          OthersStatus(
              name : "Foisal",
              imageName: "assets/3.jpg",
              time : "12:00 am"
          ),
          OthersStatus(
              name : "Nabil",
              imageName: "assets/3.jpg",
              time : "12:00 am"
          ),
          Level("Viewd Updates"),
          OthersStatus(
              name : "Sami",
              imageName: "assets/3.jpg",
              time : "12:00 am"
          ),
          OthersStatus(
              name : "Sami",
              imageName: "assets/3.jpg",
              time : "12:00 am"
          ),
          OthersStatus(
              name : "Sami",
              imageName: "assets/3.jpg",
              time : "12:00 am"
          ),

        ],
      ),
    );
  }

  Widget Level(String level){
    return         Container(
      height: 30,
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          level,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}


