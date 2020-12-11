import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_admob/firebase_admob.dart';

class SinglePlayer extends StatefulWidget {
  final String player;
  SinglePlayer({Key key, @required this.player}) : super(key: key);
  @override
  _SinglePlayerState createState() => _SinglePlayerState();
}

class _SinglePlayerState extends State<SinglePlayer> {
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
  int steps = 0;
  String isPlayer = 'X';
  bool callBack = false;
  var rand = Random();
  _SinglePlayerState() {
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
      isPlayer = 'X';
      if (text == 'Reset') {
        scoreP1 = 0;
        scoreP2 = 0;
      }
    });
  }

  void tapHandler(int i) {
    if (_board[i] == 'X' || _board[i] == 'O') {
      steps = steps;
    } else {
      _board[i] = isPlayer;
      steps += 1;
      setState(() {
        callBack = checkWin(i, steps);
      });
      if (callBack == false && steps != 9) botPlay(_board);
    }
  }

  bool checkWin(int i, int steps) {
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
        if (play == 'X') {
          scoreP1 += 1;
        } else if (play == 'O') {
          scoreP2 += 1;
        }
      });
      return true;
    } else if (steps == 9) {
      createAlertDialog(context, 'No One');
      return true;
    } else {
      return false;
    }
  }

  createAlertDialog(BuildContext context, String value) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () {},
              child: AlertDialog(
                title: value == 'No One'
                    ? Text('There Is No Winner!')
                    : Text('We Have A Winner!'),
                content: value == 'X'
                    ? Text('The Winner Is ${widget.player}')
                    : value == 'O'
                        ? Text('The Winner Is Bot')
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
              ));
        });
  }

  void botPlay(List<String> _board) {
    int rdn = rand.nextInt(9);
    if (_board[rdn] == '') {
      _board[rdn] = 'O';
      setState(() {
        steps += 1;
      });
      checkWin(rdn, steps);
    } else {
      botPlay(_board);
    }
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
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                alignment: Alignment.center,
                child: Text(
                  '${widget.player} Score : $scoreP1',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Roboto'),
                ),
              )),
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                alignment: Alignment.center,
                child: Text(
                  'Bot Score : $scoreP2',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Roboto'),
                ),
              ))
            ],
          ),
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
      ),
    );
  }

  _buildElement(int i) {
    return GestureDetector(
      onTap: () => tapHandler(i),
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
