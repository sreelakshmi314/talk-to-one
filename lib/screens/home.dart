import 'package:flutter/material.dart';
import 'package:talk_one/widgets/input_meassge.dart';
import 'package:talk_one/widgets/message_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const InputMessage(),
            const SizedBox(
              height: 20,
            ),
            MessageList(),
          ],
        ),
      ),
    );
  }
}
