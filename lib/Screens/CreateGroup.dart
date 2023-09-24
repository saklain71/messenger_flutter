import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_flutter/CustomUi/AvatarCard.dart';
import 'package:messenger_flutter/CustomUi/ContactCard.dart';
import 'package:messenger_flutter/Group/group_page.dart';
import 'package:messenger_flutter/Model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Saklain", status: "A full stack developer", icon: '', isGroup: false, time: '', currentMessage: '', id: 1),
    ChatModel(name: "Sami", status: "Flutter Developer...........", icon: '', isGroup: false, time: '', currentMessage: '', id: 2),
    ChatModel(name: "Faiyaz", status: "Web developer...", icon: '', isGroup: false, time: '', currentMessage: '', id: 3),
    ChatModel(name: "Niloy", status: "App developer....", icon: '', isGroup: false, time: '', currentMessage: '', id: 4),
    ChatModel(name: "Shahed", status: "Raect developer..", icon: '', isGroup: false, time: '', currentMessage: '', id: 5),
    ChatModel(name: "Salman", status: "Full Stack Web", icon: '', isGroup: false, time: '', currentMessage: '', id: 6),
    ChatModel(name: "Rashed", status: "Example work", icon: '', isGroup: false, time: '', currentMessage: '', id: 7),
    ChatModel(name: "Onion", status: "Sharing is caring", icon: '', isGroup: false, time: '', currentMessage: '', id: 8),
    ChatModel(name: "Robin", status: ".....", icon: '', isGroup: false, time: '', currentMessage: '', id: 9),
    ChatModel(name: "Rumy", status: "Love you Mom Dad", icon: '', isGroup: false, time: '', currentMessage: '', id: 10),
    ChatModel(name: "Nirob", status: "I find the bugs", icon: '', isGroup: false, time: '', currentMessage: '', id: 11),
  ];
  List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF128C7E),
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(
                 builder: (context)=>  GroupPage(
                   name: '',
                   userId: '',
                   groupName: '',
                 )
             ));
            },
            child: Icon(Icons.arrow_forward)),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groupmember.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index - 1].select == true) {
                          groupmember.remove(contacts[index - 1]);
                          contacts[index - 1].select = false;
                        } else {
                          groupmember.add(contacts[index - 1]);
                          contacts[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
                }),
            groupmember.isNotEmpty
            ? Align(
              child: Column(
                children: [
                  Container(
                    height: 75,
                    color: Colors.white,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].select == true)
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  groupmember.remove(contacts[index]);
                                  contacts[index].select = false;
                                });
                              },
                              child: AvatarCard(
                                contact: contacts[index],
                              ),
                            );
                          return Container();
                        }),
                  ),
                  Divider(thickness: 1,)
                ],
              ),
              alignment: Alignment.topCenter,
            )
                : Container(),
          ],
        ));
  }
}
