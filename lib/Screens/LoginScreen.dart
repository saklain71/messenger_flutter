
import 'package:flutter/material.dart';
import 'package:messenger_flutter/CustomUi/ButtonCard.dart';
import 'package:messenger_flutter/Model/ChatModel.dart';

import 'Homescreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   ChatModel? sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Saklain",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1, status: '',
    ),
    ChatModel(
      name: "Sami",
      isGroup: false,
      currentMessage: "Hi Rashed",
      time: "13:00",
      icon: "person.svg",
      id: 2, status: '',
    ),

    ChatModel(
      name: "Faiyaz",
      isGroup: false,
      currentMessage: "Hi Shahed",
      time: "8:00",
      icon: "person.svg",
      id: 3, status: '',
    ),

    ChatModel(
      name: "Niloy",
      isGroup: false,
      currentMessage: "Hi Faiyaz",
      time: "2:00",
      icon: "person.svg",
      id: 4, status: '',
    ),

    // ChatModel(
    //   name: "Ramim",
    //   isGroup: true,
    //   currentMessage: "New Post",
    //   time: "2:00",
    //   icon: "group.svg",
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatmodels.length,
          itemBuilder: (contex, index) => InkWell(
                onTap: () {
                  sourceChat = chatmodels.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Homescreen(
                                chatmodels: chatmodels,
                                sourchat: sourceChat!,
                              )));
                },
                child: ButtonCard(
                  name: chatmodels[index].name,
                  icon: Icons.person,
                ),
                // child: Column(
                //   children: const <Widget>[
                //     Icon(Icons.person),
                //     Text('Name'),
                //   ],
                // ),
              )),
    );
  }
}
