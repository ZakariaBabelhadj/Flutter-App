import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants.dart';
import 'package:flutter_application_3/models/ChatMessage.dart';

class TextMessage extends StatelessWidget {
  final ChatMessage message;
  const TextMessage({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding - 0.75, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.1),
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        message.text,
        style: TextStyle(
            color: message.isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1.color),
      ),
    );
  }
}
