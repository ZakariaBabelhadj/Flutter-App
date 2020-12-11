import 'package:flutter/material.dart';
import './gamePage.dart';

class TextInput extends StatefulWidget {
  TextInput({Key key}) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  List<String> _players = ['PlayerOne', 'PlayerTwo'];
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  String player1 = '';
  String player2 = '';
  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller1.clear();
    controller2.dispose();
    controller2.clear();
  }

  void changePlayer1(String text) {
    setState(() {
      player1 = text;
    });
  }

  void changePlayer2(String text) {
    setState(() {
      player2 = text;
    });
  }

  void pressHandler({String playerOne, String playerTwo}) {
    if (playerOne == '') {
      _players[0] = 'PlayerOne';
    } else {
      _players[0] = playerOne;
    }
    if (playerTwo == '') {
      _players[1] = 'PlayerTwo';
    } else {
      _players[1] = playerTwo;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GamePage(
                  players: _players,
                )));
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
          height: 300.0,
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
                'Enter Your Names:',
                style: TextStyle(
                    fontSize: 24.0, fontFamily: 'Roboto', color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  controller: this.controller1,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: 'Player 1',
                  ),
                  onChanged: (text) => changePlayer1(text),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  controller: this.controller2,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                  ),
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: 'Player 2',
                  ),
                  onChanged: (text) => changePlayer2(text),
                ),
              ),
              RaisedButton(
                child: Text(
                  'Play',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Roboto'),
                ),
                color: Colors.brown,
                splashColor: Colors.brown[200],
                onPressed: () =>
                    pressHandler(playerOne: player1, playerTwo: player2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
