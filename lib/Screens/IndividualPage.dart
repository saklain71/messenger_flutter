// import 'package:camera/camera.dart';
// import 'package:chatapp/CustomUI/CameraUI.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_flutter/CustomUi/OwnFileCard.dart';
import 'package:messenger_flutter/CustomUi/OwnMessageCard.dart';
import 'package:messenger_flutter/CustomUi/ReplyCard.dart';
import 'package:messenger_flutter/CustomUi/ReplyFileCard.dart';
import 'package:messenger_flutter/Model/ChatModel.dart';
import 'package:messenger_flutter/Model/MessageModel.dart';
import 'package:messenger_flutter/Screens/CameraScreen.dart';
import 'package:messenger_flutter/Screens/CameraViewPage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  IndividualPage({Key? key, required this.chatModel, required this.sourchat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  IO.Socket? socket;
  ImagePicker picker = ImagePicker();
  XFile? file;
  int popTime = 0;
  String? privateRoom;


  void disconnectSocket() {
    socket!.disconnect();
    print("Socket disconneted ${socket!.disconnected}");
  }

  @override
  void initState() {
    super.initState();
    // connect();
    _scrollController = ScrollController();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connect();
  }


  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://210.4.64.216:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.emit("signin", widget.sourchat.id);
    socket!.onConnect((data) {
      print("Connected");

      List<int> numbers = [widget.sourchat.id,widget.chatModel.id];
      numbers.sort();
      print("$numbers private-${numbers.join('-')}");
      String room = "private-${numbers.join('-')}";
      privateRoom = room;
      print(room);

      socket!.emit('joinPrivateRoom', [room]);

      // var id = [widget.sourchat.id,widget.chatModel.id];
      // id.sort();
      // room = "private-${id.join('-')}";
      // socket!.emit('joinPrivateRoom', "private-1-2");

      // socket.on('joinPrivateRoom', (privateRoom){
      // if(mounted){
      //   setState(() {
      //     room = privateRoom;
      //   });
      //   print('join-private-room >>> $room');
      // }
      // });

      socket!.on('recieveMessage', (msg) {
        print("recieveMessage  $msg");
        if(mounted){
          setMessage('destination', msg['message']);
          _scrollController.animateTo(_scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        }
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

  void sendMessage(String message, int sourceId, int targetId, ) {
    //setMessage("source", message );
    MessageModel ownMsg = MessageModel(
      type: "source",
      message: message,
      time: DateTime.now().toString().substring(10, 16),
      // path: path
    );
    messages.add(ownMsg);
    setState(() {
      messages;
    });
    socket!.emit("sendPrivateMessage", {
          "privateRoom": privateRoom.toString(),
          "message": message,
          "sourceId": sourceId,
          "targetId": targetId,
        });
  }

  void setMessage(String type, String message,) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16),
        // path: path
    );
    print("message $messages");

    if (mounted) {
      setState(() {
        messages.add(messageModel);
      });
    }
    print("message $messages");
  }

  void onImageSend(String path, String message)async{
    print("hey there working $message $path");
    for(int i = 0; i < popTime; i++){
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });
    var request = http.MultipartRequest(
      "POST", Uri.parse("http://210.4.64.216:3000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type":"multipart/form-date",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);
    print("response ${response.statusCode}");
    setMessage("source", message);
    socket!.emit("message",
        {"message": message,
          "sourceId": widget.sourchat.id,
          "targetId": widget.chatModel.id,
          "path": path
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.red,),
                onPressed: () {
                  disconnectSocket();
                  Navigator.of(context).pop();
                },
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                // IconButton(icon: Icon(Icons.videocam), onPressed: () {}),

                Center(child:
                Text(socket!.connected.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: socket!.connected ? Colors.blueGrey : Colors.red,
                  ))),
                IconButton(icon: Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media, links, and docs"),
                        value: "Media, links, and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                      PopupMenuItem(
                        child: Text("Wallpaper"),
                        value: "Wallpaper",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    //height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          if(messages[index].path != null){
                            return OwnFileCard(
                                path: messages[index].path!,
                                message: messages[index].message,
                                time : messages[index].time
                            );
                          }else{
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
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
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      bottomSheet());
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: () {
                                              setState(() {
                                                popTime = 2;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          CameraScreen(
                                                              onImageSend: onImageSend,
                                                          )));
                                            },
                                          ),
                                        ],
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
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                            Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            _controller.text,
                                            widget.sourchat.id,
                                            widget.chatModel.id,
                                        );
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
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document", (){}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera", (){
                    setState(() {
                      popTime = 3;
                    });
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> CameraScreen(
                        onImageSend: onImageSend)));
                  }),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                          ()async{
                    setState(() {
                      popTime = 2;
                    });
                     file = await picker.pickImage(source: ImageSource.gallery);
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context)=> CameraViewPage(
                         path: file!.path,
                         onImageSend: onImageSend,
                              ),
                            ),
                     );
                  })
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio", (){}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location", (){}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact", (){}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    // return EmojiPicker(
    //     rows: 4,
    //     columns: 7,
    //     onEmojiSelected: (emoji, category) {
    //       print(emoji);
    //       setState(() {
    //         _controller.text = _controller.text + emoji.emoji;
    //       });
    //     });
    return Container();
  }
}
