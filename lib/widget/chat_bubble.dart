import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.message,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(message.id,style:const  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ));
  }
}

class ChatBubbleForFrind extends StatelessWidget {
  const ChatBubbleForFrind({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          width: 120,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.message,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(message.id,style:const  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
              maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
          //ListTile(
          //   minVerticalPadding: 10,
          //   minLeadingWidth: 10,
          //   subtitle: Text(message.id),
          //   title: Text(message.message, style: const TextStyle(color: Colors.white),),
          //
          //
          // )
          ),
    );
  }
}
