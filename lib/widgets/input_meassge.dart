import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_one/model/message.dart';
import 'package:talk_one/providers/message_provider.dart';
import 'package:talk_one/widgets/message_play.dart';

class InputMessage extends ConsumerStatefulWidget {
  const InputMessage({super.key});

  @override
  ConsumerState<InputMessage> createState() {
    return _InputMessageState();
  }
}

class _InputMessageState extends ConsumerState<InputMessage> {
  TextEditingController? _inputTextController;
  FocusNode? _focusNode;
  bool _messageExist = false;
  String _enteredText = '';

  void _showKeyboard() {
    _focusNode!.requestFocus();
  }

  void _dismissKeyboard() {
    _focusNode!.unfocus();
  }

  // Function to check input contain message or not?
  void _changeStatus() {
    setState(() {
      _messageExist = !_messageExist;
    });
  }

  // Function to reset playable message
  void _restMessage(String message) {
    print('New message-------------------------- $message');
    setState(() {
      _enteredText = message;
      _messageExist = true;
      _inputTextController = TextEditingController(text: _enteredText);
    });
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    // added a register a closure to be called when the _inputTextController changes.
    _inputTextController = TextEditingController()
      ..addListener(() {
        if (_inputTextController != null) {
          setState(() {
            _enteredText = _inputTextController!.text;
          });
        } else {
          setState(() {
            _messageExist = false;
          });
        }
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _inputTextController!.dispose();
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageToPlay = ref.watch(messageProvider);
    var chosenText = messageToPlay.message;

    // Removing '...' value from message if exists
    const identifier = '...';
    chosenText = chosenText.replaceAll(identifier, '');

    if (chosenText.trim().isNotEmpty) {
      _restMessage(chosenText);
    }

    // print('value of _enteredText ------ - $_enteredText');
    Widget activeButton = IconButton(
      onPressed: _showKeyboard,
      icon: Icon(
        Icons.keyboard,
        size: 32,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );

    if (_messageExist) {
      activeButton = IconButton(
        onPressed: () {
          _dismissKeyboard();
          _inputTextController!.clear();
          _enteredText= '';
          ref.watch(messageProvider.notifier).chosenMessage(
                Message(message: _enteredText),
              );
          _changeStatus();
        },
        icon: Icon(
          Icons.close_outlined,
          size: 32,
          color: Theme.of(context).colorScheme.error,
        ),
      );
    }

    return SizedBox(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        child: TextField(
          maxLines: null,
          controller: _inputTextController,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
          cursorColor: Theme.of(context).colorScheme.onBackground,
          keyboardType: TextInputType.text,
          focusNode: _focusNode,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
            prefixIcon: activeButton,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1.0,
              ),
            ),
            suffixIcon: MessagePlay(
              typedMessage: _enteredText,
            ),
          ),
        ),
      ),
    );
  }
}
