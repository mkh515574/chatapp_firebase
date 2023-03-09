import 'package:chatapp/constants.dart';
import 'package:chatapp/cubit/chat/chat_cubit.dart';
import 'package:chatapp/cubit/chat/chat_states.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/screen/auth/login.dart';

import 'package:chatapp/widget/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static String id = "HomePage";
  final _controller = ScrollController();

  TextEditingController messageController = TextEditingController();

  @override

  @override
  Widget build(BuildContext context) {
   // var emailll = ModalRoute.of(context)!.settings.arguments;
    //String email = emailll as String;
    String email = FirebaseAuth.instance.currentUser!.email!;
    var messageList =
        BlocProvider.of<ChatCubit>(context).messagesList;
    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,

          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.popAndPushNamed(context, LoginPage.id);
                  });
                },
                icon: const Icon(Icons.logout_outlined))
          ],
          title: const Text("Chat App"),
          backgroundColor: kPrimaryColor,
        ),

        drawer:Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:  [
                  Container(
                    decoration:BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 200,
                    width: double.infinity,

                    child:Image.network(imgUrl,fit: BoxFit.fill,) ,

                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        body: Column(children: [
          Expanded(child: BlocBuilder<ChatCubit, ChatStates>(

            builder: (context, state) {

              return ListView.builder(
                reverse: true,
                controller: _controller,
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return messageList[index].id == email
                      ? ChatBubble(message: messageList[index])
                      : ChatBubbleForFrind(
                          message: messageList[index],
                        );
                },
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: messageController,
              onSubmitted: (data) {
                messageController.text = data;

                BlocProvider.of<ChatCubit>(context)
                    .sendMassage(massage: messageController.text, email: email);
                messageController.clear();
                if (kDebugMode) {
                  print(email);
                }
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 2),
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration(
                  suffixIconColor: kPrimaryColor,
                  hintText: "Message",
                  suffixIcon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: kPrimaryColor))),
            ),
          )
        ]));
  }
}
