import 'package:flutter/material.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:learn_chess_board/widgets/enums/field_label_type.dart';
import 'package:provider/src/provider.dart';
import 'enums/player_side.dart';
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
          labelType: context.watch<GameData>().getLabelType,
          playerSide: context.watch<GameData>().getSide,
          ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
    );
  }
}
