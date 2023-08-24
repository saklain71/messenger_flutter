import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_flutter/CustomUi/ButtonCard.dart';
import 'package:messenger_flutter/CustomUi/ContactCard.dart';
import 'package:messenger_flutter/Model/ChatModel.dart';

import 'CreateGroup.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {

    List<ChatModel> contacts = [
      ChatModel(name: "Rashed", status: "A full stack developer", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Ramim", status: "Flutter Developer...........", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Sami", status: "Web developer...", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Faiyaz", status: "App developer....", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Shahed", status: "Raect developer..", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Niloy", status: "Full Stack Web", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Testing1", status: "Example work", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Testing2", status: "Sharing is caring", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Robin", status: ".....", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Rumy", status: "Love you Mom Dad", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
      ChatModel(name: "Tester", status: "I find the bugs", icon: '', isGroup: false, time: '', currentMessage: '', id: 0),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "56 contacts",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 26,
              ),
              onPressed: () {}),
          PopupMenuButton<String>(
            padding: EdgeInsets.all(0),
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
         itemCount: contacts.length + 2,
          itemBuilder: (contex, index){
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CreateGroup()));
                },
                child: ButtonCard(
                  icon: Icons.group,
                  name: "New group",
                ),
              );
            } else if (index == 1) {
              return ButtonCard(
                icon: Icons.person_add,
                name: "New contact",
              );
            }
            return ContactCard(
              contact: contacts[index - 2],
            );
          }
      ),
    );
  }
}
