import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:provider/provider.dart';

class DialogHelper {
  static void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: COMMON_BACKGROUND,
      title: const Text("Training over", style: TextStyle(color: Colors.white)),
      //Как то сделать по человески надо тут...
      content: Text('''
Full time:   ${context.read<GameData>().getTimeString} 
Passed count: ${context.read<GameData>().getPassed}
Fail count: ${context.read<GameData>().getFails} ''', style: const TextStyle(color: Colors.white)),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
