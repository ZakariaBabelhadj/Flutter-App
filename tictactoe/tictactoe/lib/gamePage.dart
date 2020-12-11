import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

class GamePage extends StatefulWidget {
  final List<String> players;
  GamePage({Key key, @required this.players}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps', 'game apps'],
    testDevices: <String>[],
    childDirected: true,
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-7964541967487235/9099861758",
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd Event $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-7964541967487235/3042021189",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd Event $event");
        });
  }

  List<String> _board = new List(9);
  int scoreP1 = 0;
  int scoreP2 = 0;
  _GamePageState() {
    for (var i = 0; i < _board.length; i++) {
      _board[i] = '';
    }
  }
  void resetGame({String text}) {
    setState(() {
      for (var i = 0; i < _board.length; i++) {
        _board[i] = '';
      }
      steps = 0;
      if (text == 'Reset') {
        scoreP1 = 0;
        scoreP2 = 0;
        player = 'X';
      }
    });
  }

  createAlertDialog(BuildContext context, String value) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: value == 'No One'
                ? Text('There Is No Winner!')
                : Text('We Have A Winner!'),
            content: value == 'X'
                ? Text('The Winner Is ${widget.players[0]}')
                : value == 'O'
                    ? Text('The Winner Is ${widget.players[1]}')
                    : Text('Tied Game!!'),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Play Agian'),
                onPressed: () => {
                  createInterstitialAd()
                    ..load()
                    ..show(),
                  resetGame(),
                  Navigator.of(context).pop()
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-7964541967487235~6146395356");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text('TicTacToe'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                alignment: Alignment.center,
                child: Text(
                  '${widget.players[0]} X Score : $scoreP1',
                  style: TextStyle(
                      color: player == 'X' ? Colors.red : Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Roboto'),
                ),
              )),
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                alignment: Alignment.center,
                child: Text(
                  '${widget.players[1]} O Score : $scoreP2',
                  style: TextStyle(
                      color: player == 'X' ? Colors.white : Colors.blue,
                      fontSize: 20.0,
                      fontFamily: 'Roboto'),
                ),
              )),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: _buildElement(0),
                ),
                Expanded(
                  child: _buildElement(1),
                ),
                Expanded(
                  child: _buildElement(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: _buildElement(3),
                ),
                Expanded(
                  child: _buildElement(4),
                ),
                Expanded(
                  child: _buildElement(5),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: _buildElement(6),
                ),
                Expanded(
                  child: _buildElement(7),
                ),
                Expanded(
                  child: _buildElement(8),
                ),
              ],
            ),
            Container(
                width: 100.0,
                child: RaisedButton(
                    color: Colors.brown,
                    splashColor: Colors.brown[200],
                    onPressed: () => resetGame(text: 'Reset'),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Reset',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Roboto'),
                        ),
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                        )
                      ],
                    )))
          ],
        ));
  }

  void checkWin(int i, int steps) {
    if (_board[0] == _board[1] && _board[0] == _board[2] && _board[0] != '' ||
        _board[0] == _board[3] && _board[0] == _board[6] && _board[0] != '' ||
        _board[0] == _board[4] && _board[0] == _board[8] && _board[0] != '' ||
        _board[3] == _board[4] && _board[3] == _board[5] && _board[3] != '' ||
        _board[6] == _board[7] && _board[6] == _board[8] && _board[6] != '' ||
        _board[1] == _board[4] && _board[1] == _board[7] && _board[1] != '' ||
        _board[2] == _board[5] && _board[2] == _board[8] && _board[2] != '' ||
        _board[2] == _board[4] && _board[2] == _board[6] && _board[2] != '') {
      var play = _board[i];
      createAlertDialog(context, play);
      setState(() {
        if (play == 'X')
          scoreP1 += 1;
        else if (play == 'O') scoreP2 += 1;
      });
    } else {
      if (steps == 9) createAlertDialog(context, 'No One');
    }
  }

  void changeColor() {}
  int steps = 0;
  String player = 'X';
  _buildElement(int i) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_board[i] == 'X' || _board[i] == 'O') {
          } else {
            _board[i] = player;
            if (player == 'X') {
              player = 'O';
              steps += 1;
            } else {
              player = 'X';
              steps += 1;
            }
          }
        });
        checkWin(i, steps);
      },
      child: Container(
        width: 90.0,
        margin: EdgeInsets.all(8.5),
        padding: EdgeInsets.all(8.5),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: _board[i] == 'X'
                ? Colors.redAccent
                : _board[i] == 'O'
                    ? Colors.blueAccent
                    : Colors.white,
            border: Border.all(
              color: Colors.black,
            )),
        child: Text(
          _board[i],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 100.0, color: Colors.white),
        ),
      ),
    );
  }
}
