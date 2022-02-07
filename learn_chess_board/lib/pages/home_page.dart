import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/widgets/chess_board.dart';
import 'package:learn_chess_board/widgets/game_tv.dart';
import 'package:learn_chess_board/widgets/start_button.dart';

//Home Page class
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.commonBackground,
        child: Column(
          children:  [
            const ChessBoard(), // Board
            const GameTv(), // Selectors, Game TV
            StartButton(), // Start / Stop
          ],
        ),
      ),
    );
  }
}