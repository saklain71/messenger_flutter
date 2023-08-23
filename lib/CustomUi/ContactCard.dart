import 'package:flutter/cupertino.dart';
import 'package:messenger_flutter/Model/ChatModel.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({Key? key, required ChatModel contact}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
