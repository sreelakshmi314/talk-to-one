import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_one/model/message.dart';
import 'package:talk_one/providers/message_provider.dart';

class MessagePlay extends ConsumerWidget {
  MessagePlay({
    super.key,
    this.typedMessage = '',
  });

  final String typedMessage;
  final FlutterTts flutterTts = FlutterTts();

  void textToSpeech(String message) async {
    var enteredText = message;
  print('message--------------------------$message');
    if (enteredText.trim().isEmpty) {
      return;
    } else if (enteredText.contains('...')) {
      const identifier = '...';
      enteredText = enteredText.replaceAll(identifier, '');
    }
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(enteredText);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outMessage = ref.watch(messageProvider);
    var messagePlay = outMessage.message;

    return IconButton(
      onPressed: () {
        if (typedMessage.trim().isNotEmpty) {
          messagePlay = typedMessage;
          ref.watch(messageProvider.notifier).chosenMessage(
                Message(message: messagePlay),
              );
        }
        textToSpeech(messagePlay);
      },
      icon: Icon(
        Icons.speaker_phone_rounded,
        // spatial_audio_off_rounded,
        size: 32,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
