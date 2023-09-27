import 'package:flutter/material.dart';
import 'package:messenger_flutter/Model/ChatModel.dart';
import 'package:messenger_flutter/NewScreen/LandingScreen.dart';
import 'package:messenger_flutter/Pages/CameraPage.dart';
import 'package:messenger_flutter/Pages/ChatPage.dart';
import 'package:messenger_flutter/Pages/StatusPage.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key, required this.chatmodels, required this.sourchat}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {



  final List<ChatModel> chatmodels = [

    ChatModel(
      name: "FriendsGroup",
      isGroup: true,
      currentMessage: "New Post",
      time: "2:00",
      icon: "group.svg",
      id: 11,
      status: 'grouping texting',
    ),

    ChatModel(
      name: "TeachersGroup",
      isGroup: true,
      currentMessage: "New Post",
      time: "2:00",
      icon: "group.svg",
      id: 12,
      status: 'grouping texting',
    ),

    ChatModel(
      name: "StudentsGroup",
      isGroup: true,
      currentMessage: "New Post",
      time: "2:00",
      icon: "group.svg",
      id: 13,
      status: 'grouping texting',
    ),
  ];



  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    widget.chatmodels.addAll(chatmodels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's Chat"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "Land",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const Text("Camera"),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourchat: widget.sourchat,
          ),
          const StatusPage(),
          const LandingScreen()
        ],
      ),
    );
  }
}
