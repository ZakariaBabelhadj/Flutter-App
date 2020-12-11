import 'package:flutter/material.dart';
import 'package:tictactoe/singlePlay.dart';

class InputPlayer extends StatefulWidget {
  InputPlayer({Key key}) : super(key: key);

  @override
  _InputPlayerState createState() => _InputPlayerState();
}

class _InputPlayerState extends State<InputPlayer> {
  final controller = TextEditingController();
  String player = '';
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void changeHandler(String text) {
    setState(() {
      player = text;
    });
  }

  void pressHandler(String text) {
    if (text == '') {
      player = 'PlayerOne';
    } else {
      player = text;
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SinglePlayer(player: player)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text('TicTacToe'),
        ),
        body: Center(
          child: Container(
              margin: EdgeInsets.all(20),
              height: 200.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 4.0, color: Colors.brown),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Entre Your Name: ',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    width: 300.0,
                    child: TextField(
                      controller: this.controller,
                      onChanged: (text) => changeHandler(text),
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        hintText: 'Player',
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => pressHandler(player),
                    child: Text(
                      'Play',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Roboto'),
                    ),
                    color: Colors.brown,
                    splashColor: Colors.brown[200],
                  )
                ],
              )),
        ));
  }
}
