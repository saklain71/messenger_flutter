import 'package:flutter/material.dart';
import 'package:messenger_flutter/Group/group_page.dart';
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
                          nameController.clear();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> GroupPage(
                                  name: name,
                                  userId : uuid.v1()
                              ))
                          );
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
