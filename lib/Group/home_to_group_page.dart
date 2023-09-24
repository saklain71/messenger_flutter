import 'package:flutter/material.dart';
import 'package:messenger_flutter/Group/group_page.dart';
import 'package:messenger_flutter/Model/ChatModel.dart';
import 'package:messenger_flutter/Screens/Homescreen.dart';
import 'package:uuid/uuid.dart';

class HomeToGroup extends StatefulWidget {
  const HomeToGroup({Key? key,}) : super(key: key);
  @override
  State<HomeToGroup> createState() => _HomeToGroupState();
}

class _HomeToGroupState extends State<HomeToGroup> {

  TextEditingController nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  var uuid = const Uuid();

  ChatModel? sourceChat;
  List<ChatModel> chatmodels = [

    // ChatModel(
    //   name: "Saklain",
    //   isGroup: false,
    //   currentMessage: "Hi Everyone",
    //   time: "4:00",
    //   icon: "person.svg",
    //   id: 1,
    //   status: '',
    // ),

    // ChatModel(
    //   name: "Sami",
    //   isGroup: false,
    //   currentMessage: "Hi Rashed",
    //   time: "13:00",
    //   icon: "person.svg",
    //   id: 2,
    //   status: '',
    // ),

    // ChatModel(
    //   name: "Faiyaz",
    //   isGroup: false,
    //   currentMessage: "Hi Shahed",
    //   time: "8:00",
    //   icon: "person.svg",
    //   id: 3,
    //   status: '',
    // ),

    // ChatModel(
    //   name: "Niloy",
    //   isGroup: false,
    //   currentMessage: "Hi Faiyaz",
    //   time: "2:00",
    //   icon: "person.svg",
    //   id: 4,
    //   status: '',
    // ),

    ChatModel(
      name: "Friends Group",
      isGroup: true,
      currentMessage: "New Post",
      time: "2:00",
      icon: "group.svg",
      id: 11,
      status: 'grouping texting',
    ),
    ChatModel(
      name: "Teachers Group",
      isGroup: true,
      currentMessage: "New Post",
      time: "2:00",
      icon: "group.svg",
      id: 12,
      status: 'grouping texting',
    ),
    ChatModel(
      name: "Students Group",
      isGroup: true,
      currentMessage: "New Post",
      time: "2:00",
      icon: "group.svg",
      id: 13,
      status: 'grouping texting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: ()=> showDialog(
              context: context,
              builder: (BuildContext context)=> AlertDialog(
                title: Text(
                    "Write Your Name",
                  style: TextStyle(
                      fontSize: 18,
                      color:  Colors.blueAccent
                  ),
                ),
                content: Form(
                  key: formkey,
                  child: TextFormField(
                    controller: nameController,
                    validator: (value){
                      if(value == null || value.length <3){
                        return "User must have proper name";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                          "cancel",
                        style: TextStyle(
                          fontSize: 16,
                          color:  Colors.red
                        ),
                      )),
                  TextButton(
                      onPressed: (){

                        print(nameController.text.toString());
                        if(formkey.currentState!.validate()){
                          String name = nameController.text;
                          sourceChat = ChatModel(
                            name: name.toString(),
                            isGroup: false,
                            currentMessage: "New Post",
                            time: "2:00",
                            icon: "person.svg",
                            id: 1,
                            status: 'Nothing',
                          );
                          nameController.clear();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> Homescreen(
                                chatmodels: chatmodels,
                                sourchat: sourceChat!,

                              ))
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context)=> GroupPage(
                          //         name: name,
                          //         userId : uuid.v1(),
                          //         groupName: '',
                          //     ))
                          // );
                        }
                      },
                      child: Text(
                          "Enter",
                        style: TextStyle(
                            fontSize: 16,
                            color:  Colors.greenAccent
                        )
                      )),
                ],
              )),
          child: Text(
              "Connect To Chat Group",
            style: TextStyle(
                fontSize: 26,
                color:  Colors.blueAccent
            ),
          ),
        ),
      ),
    );
  }
}
