import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/utils/text_utils.dart';
import 'package:learn_chess_board/widgets/chess_board.dart';
import 'package:learn_chess_board/widgets/game_tv.dart';
import 'package:learn_chess_board/widgets/start_button.dart';

//Home Page class
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _timeString = "00:00";
  int _startTimer = 0;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: COMMON_BACKGROUND,
        child: Column(
          children: const [
            ChessBoard(),   // Board
            GameTv(),       // Selectors, Game TV
            StartButton(),  // Start / Stop
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _startTimer++;
          _timeString = TextUtils.getTimeString(123);
        },
      ),
    );
  }
}
