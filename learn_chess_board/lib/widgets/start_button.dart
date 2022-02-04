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
      state.stopGame();
      DialogHelper.showAlertDialog(context);
    } else {
      state.reset();
      state.startGame();
    }
  }
}
