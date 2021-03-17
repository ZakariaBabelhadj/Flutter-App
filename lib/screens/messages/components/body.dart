import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants.dart';
import 'package:flutter_application_3/models/ChatMessage.dart';
import 'package:flutter_application_3/screens/messages/components/chat_input_field.dart';
import 'package:flutter_application_3/screens/messages/components/message.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) {
                Message(
                  message: demeChatMessages[index],
                );
              }),
        )),
        ChatInputField()
      ],
    );
  }
}
