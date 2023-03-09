import 'package:chatapp/cubit/chat/chat_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/message_model.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());




  CollectionReference message =
      FirebaseFirestore.instance.collection(kCollection);
  List<MessageModel> messagesList= [];

  void sendMassage({required String massage, required String email}) {
    message.add({
      kMessage:massage,
      kId: email,
      kTime: DateTime.now(),
    }).then((value) {

    });
  }



  void getMassages(){
    message.orderBy(kTime, descending: true).snapshots().listen((event) {

      print(event.docs);
      messagesList.clear();
      for(var docs in event.docs){

        messagesList.add(MessageModel.fromJson(docs));
      }
      print("success");
      emit(ChatMassageSuccess(messages: messagesList));
    });
  }



  void deleteUser({required var id}) {
     message
        .doc("${id}")
        .delete()
        .then((value){
       print("User Deleted");
       getMassages();
     })
        .catchError((error) => print("Failed to delete user: $error"));

  }
}
