import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:learn_chess_board/utils/dialog_helper.dart';
import 'package:provider/provider.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
            onPressed: () {
              _onStartButton(context);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.buttonBackground, borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                child: Text(
                  context.watch<GameData>().isStarted ? "STOP" : "START",
                  style: const TextStyle(color: AppColors.buttonText, fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }

  _onStartButton(BuildContext context) {
    var state = context.read<GameData>();
    if (state.isStarted) {
      state.stopGame();
      DialogHelper.showAlertDialog(context);
    } else {
      state.reset();
      state.startGame();
    }
  }
}
