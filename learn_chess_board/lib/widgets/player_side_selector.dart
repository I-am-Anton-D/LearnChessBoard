import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:provider/provider.dart';
import 'enums/player_side.dart';

class PlayerSideSelector extends StatelessWidget {
  const PlayerSideSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(left: Dims.mediumPadding),
            child: const Text(I10n.selectSide)),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ...PlayerSide.values.map((it)=> _buildPlayerSideRadioButton(it, it.getLabel, context)).toList()
        ]),
      ],
    );
  }

  //Select player side Radio button
  Widget _buildPlayerSideRadioButton(PlayerSide side, String radioLabel, BuildContext context) {
    return Row(children: [
      Radio(
        value: side,
        groupValue: context.watch<GameData>().getSide,
        onChanged: (value) => context.read<GameData>().selectSide(value as PlayerSide)
      ),
      Text(radioLabel)
    ]);
  }
}
