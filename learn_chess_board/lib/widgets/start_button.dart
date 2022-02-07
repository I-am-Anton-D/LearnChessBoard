import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:learn_chess_board/utils/dialog_helper.dart';
import 'package:provider/provider.dart';

class StartButton extends StatelessWidget {
  Timer? _timer;
  int _gameSeconds = 30;

  StartButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
            onPressed: () => _onStartButton(context),
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.buttonBackground, borderRadius: BorderRadius.circular(Dims.smallRadius)),
                alignment: Alignment.center,
                width: double.infinity,
                height: Dims.buttonHeight,
                child: Text(
                  context.watch<GameData>().isStarted ? I10n.stop : I10n.start,
                  style: const TextStyle(color: AppColors.buttonText, fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }

  _onStartButton(BuildContext context) {
    var state = context.read<GameData>();
    if (state.isStarted) {
      _stopGame(state, context);
    } else {
      _gameSeconds = 30;
      state.updateTimeString(_gameSeconds);
      state.reset();
      state.startGame();
      _startTimer(context);
    }
  }

  _startTimer(BuildContext context) {
    var state = context.read<GameData>();
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      _gameSeconds--;
      state.updateTimeString(_gameSeconds);
      if (_gameSeconds == 0) {
        _stopGame(state, context);
      }
    });
  }

  void _stopGame(GameData state, BuildContext context) {
    _timer?.cancel();
    state.stopGame();
    DialogHelper.showFinalDialog(context, _gameSeconds);
  }
}

