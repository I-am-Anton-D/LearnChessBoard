import 'package:flutter/material.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:provider/provider.dart';
import 'field.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 64,
      itemBuilder: (BuildContext context, int index) => Field(
          index: index,
          labelType: context.watch<GameData>().getLabelType,  //FULL, FIRST LINE, NONE
          playerSide: context.watch<GameData>().getSide,      //WHITE SIDE, BLACK SIDE
          ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
    );
  }
}
