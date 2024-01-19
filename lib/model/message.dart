import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Message {
  Message({
    required this.message,
    this.icon = ''
  }) : id = uuid.v4();

  final String id;
  final String message;
  final String icon;
}
