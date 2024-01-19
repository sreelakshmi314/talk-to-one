import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_one/data/dummy.dart';
import 'package:talk_one/providers/message_provider.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
    required this.onClosing,
  });

  final void Function() onClosing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.9),
                Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit_note,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Saved Phrases',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.edit_note_rounded),
                // ),
              ],
            ),
          ),
          for (final message in savedPhrases)
            InkWell(
              child: ListTile(
                onTap: () {
                  onClosing();
                  ref.watch(messageProvider.notifier).chosenMessage(message);
                  Navigator.of(context).pop();
                },
                title: Text(message.message,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 20)),
              ),
            ),
          // ListView.builder(itemBuilder: (context, index) => ListTile(title: Text(.),))
        ],
      ),
    );
  }
}
