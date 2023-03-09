import '../../models/message_model.dart';

abstract class ChatStates{}
class ChatInitial extends ChatStates{}
class ChatMassageSuccess extends ChatStates{
  List<MessageModel> messages;

  ChatMassageSuccess({required this.messages});
}