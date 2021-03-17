import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/primary_button.dart';
import 'package:flutter_application_3/constants.dart';
import 'package:flutter_application_3/screens/chats/chats_screen.dart';

class SignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? "assets/images/Logo_light.png"
                    : "assets/images/Logo_dark.png",
                height: 146,
              ),
              Spacer(),
              PrimaryButton(
                  text: "Sign In",
                  color: Theme.of(context).colorScheme.primary,
                  press: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()))),
              SizedBox(
                height: kDefaultPadding * 1.5,
              ),
              PrimaryButton(
                text: "Sign up",
                press: () {},
                color: Theme.of(context).colorScheme.secondary,
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
