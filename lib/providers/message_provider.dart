import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_one/model/message.dart';

class MessageNotifier extends StateNotifier<Message> {
  MessageNotifier() : super(Message(message: '', icon: ''));

  chosenMessage(message) {
    state = message;
  }
}

final messageProvider = StateNotifierProvider<MessageNotifier, Message>(
  (ref) => MessageNotifier(),
);
