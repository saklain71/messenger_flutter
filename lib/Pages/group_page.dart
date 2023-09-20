import 'package:flutter/material.dart';
import 'package:messenger_flutter/Model/MessageModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  IO.Socket? socket;
  TextEditingController _controller = TextEditingController();
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
      socket!.on("message", (msg) {
        print("msg $msg");
        socket!.emit('msg', 'test');
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    // socket.on("message", (data) {
    //   print("message from server $data");
    // });
    print(socket!.connected);
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print("onConnectError $err"));
    socket!.onError((err) => print("onError $err"));
    print(socket!.disconnected);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container()
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
                            controller: _controller,
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
                              // suffixIcon: Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     IconButton(
                              //       icon: Icon(Icons.attach_file),
                              //       onPressed: () {
                              //         showModalBottomSheet(
                              //             backgroundColor:
                              //             Colors.transparent,
                              //             context: context,
                              //             builder: (builder) =>
                              //                 bottomSheet());
                              //       },
                              //     ),
                              //     IconButton(
                              //       icon: Icon(Icons.camera_alt),
                              //       onPressed: () {
                              //         setState(() {
                              //           popTime = 2;
                              //         });
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (builder) =>
                              //                     CameraScreen(
                              //                       onImageSend: onImageSend,
                              //                     )));
                              //       },
                              //     ),
                              //   ],
                              // ),
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
                              if (sendButton) {
                                // _scrollController.animateTo(
                                //     _scrollController
                                //         .position.maxScrollExtent,
                                //     duration:
                                //     Duration(milliseconds: 300),
                                //     curve: Curves.easeOut);
                                // sendMessage(
                                //     _controller.text,
                                //     widget.sourchat.id,
                                //     widget.chatModel.id,
                                //     ""
                                // );
                                _controller.clear();
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
