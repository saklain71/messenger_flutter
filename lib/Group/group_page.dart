import 'package:flutter/material.dart';
import 'package:messenger_flutter/Group/grp_msg_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'other_msg_widget.dart';
import 'own_msg_widget.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key, required this.name, required this.userId, required this.groupName}) : super(key: key);
  final String name;
  final String userId;
  final String groupName;


  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  IO.Socket? socket;
  List<MsgModel> listMsg = [];

  TextEditingController _msgController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://210.4.64.216:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    //socket.emit("signin", widget.sourchat.id);
    socket!.onConnect((data) {
      print("Connected");
      //socket!.emit('sendMsg', 'test emit event');
      socket!.on('sendMsgServer', (msgServer){
        print('msg from server $msgServer');

        if(msgServer["userId"] != widget.userId){
          if(mounted){
            setState(() {
              listMsg.add(
                  MsgModel(
                      type: msgServer['type'],
                      msg: msgServer['msg'],
                      sender: msgServer['senderName']
                  )
              );
            });
          }

        }
      });
      socket!.on("message", (msg) {
        print("msg $msg");
        // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });

    print(socket!.connected);
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print("onConnectError $err"));
    socket!.onError((err) => print("onError $err"));
    print(socket!.disconnected);

  }

  void sendMesg(String msg, String senderName) {
    // setMessage("source", message, path);
    MsgModel ownMsg = MsgModel(
        type: "ownMsg",
        msg: msg,
        sender: senderName
    );
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit('sendMsg',
        {
          'type': 'ownMsg',
          'msg': msg,
          'senderName': senderName,
          "userId": widget.userId
        });
  }

   void disconnectSocket() {
    socket!.disconnect();
    print("Socket disconneted ${socket!.disconnected}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connect();
    print('id from chat box ${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.red,),
          onPressed: () {
            disconnectSocket();
            Navigator.of(context).pop();
          },
        ),
        title:  Text(widget.groupName.toString()),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: listMsg.length,
                  itemBuilder: (context, index){
                    if(listMsg[index].type == "ownMsg"){
                      return OwnMsgWidget(
                          sender: listMsg[index].sender,
                          msg: listMsg[index].msg
                      );
                    }else{
                      return OtherMsgWidget(
                          sender: listMsg[index].sender,
                          msg: listMsg[index].msg
                      );
                    }
                  }
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 55,
                        child: Card(
                          margin: EdgeInsets.only(
                              left: 2, right: 2, bottom: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            controller: _msgController,
                            focusNode: focusNode,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            onChanged: (value) {
                              if (value.length > 0) {
                                setState(() {
                                  sendButton = true;
                                });
                              } else {
                                setState(() {
                                  sendButton = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: IconButton(
                                icon: Icon(
                                  show
                                      ? Icons.keyboard
                                      : Icons.emoji_emotions_outlined,
                                ),
                                onPressed: () {
                                  if (!show) {
                                    focusNode.unfocus();
                                    focusNode.canRequestFocus = false;
                                  }
                                  setState(() {
                                    show = !show;
                                  });
                                },
                              ),
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                          right: 2,
                          left: 2,
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xFF128C7E),
                          child: IconButton(
                            icon: Icon(
                              sendButton ? Icons.send : Icons.mic,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              String msg = _msgController.text;
                              if (sendButton) {
                                if(msg.isNotEmpty){
                                  sendMesg(
                                      _msgController.text,
                                      widget.name
                                  );
                                }
                                _msgController.clear();
                                setState(() {
                                  sendButton = false;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
