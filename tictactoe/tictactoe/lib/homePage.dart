import 'package:flutter/material.dart';
import './playInput.dart';
import './inputPlayer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
            padding: EdgeInsets.all(20),
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
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    'Chose Play Mode: ',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.brown,
                    ),
                    Container(
                      width: 200.0,
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: RaisedButton(
                        color: Colors.brown,
                        splashColor: Colors.brown[200],
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputPlayer()))
                        },
                        child: Text(
                          'Sigle Player',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.brown,
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.brown,
                        ),
                      ],
                    ),
                    Container(
                        width: 200.0,
                        child: RaisedButton(
                          color: Colors.brown,
                          splashColor: Colors.brown[200],
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TextInput()))
                          },
                          child: Text(
                            'MultiPlayer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'Roboto'),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
