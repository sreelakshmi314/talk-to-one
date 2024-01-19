import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_one/providers/message_provider.dart';

class MessagePlay extends ConsumerWidget {
  MessagePlay({
    super.key
  });

  final FlutterTts flutterTts = FlutterTts();

  void textToSpeech(String message) async {
    var enteredText = message;

    if (enteredText.trim().isEmpty) {
      return;
    }
    else if (enteredText.contains('...')) {
      const identifier = '...';
      enteredText = enteredText.replaceAll(identifier, '');
    }
    print("message -------- $enteredText");
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(enteredText);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outMessage = ref.watch(messageProvider);

    return IconButton(
      onPressed: () {
        textToSpeech(outMessage.message);
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
