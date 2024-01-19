import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_one/model/message.dart';
import 'package:talk_one/providers/message_provider.dart';

class MessageItem extends ConsumerWidget {
  const MessageItem({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.watch(messageProvider.notifier).chosenMessage(message);
      },
      child: Card(
        // margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message.message,
          ),
        ),
      ),
    );
  }
}
