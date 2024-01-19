import 'package:flutter/material.dart';
import 'package:talk_one/data/dummy.dart';
import 'package:talk_one/widgets/message_item.dart';

class MessageList extends StatelessWidget {
  MessageList({super.key});
  final messageListItems = dummyList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: messageListItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2
        ),
        itemBuilder: (ctx, index) => MessageItem(
          message: messageListItems[index],
        ),
      ),
    );
  }
}
