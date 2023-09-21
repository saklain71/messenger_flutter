import 'package:flutter/material.dart';

class OwnMsgWidget extends StatelessWidget {
  const OwnMsgWidget({Key? key, required this.sender, required this.msg}) : super(key: key);
  final String sender;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 60,
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 1,
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                    msg,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                )
                ],
            ),
          ),
        ),
      ),
    );
  }
}
