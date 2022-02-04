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
            padding: const EdgeInsets.only(left: DIM_MEDIUM_PADDING),
            child: const Text(SELECT_SIDE)),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _buildPlayerSideRadioButton(PlayerSide.white, context),
          const Text('WHITE'),
          _buildPlayerSideRadioButton(PlayerSide.black, context),
          const Text('BLACK')
        ]),
      ],
    );
  }

  //Select player side Radio button
  Radio<PlayerSide> _buildPlayerSideRadioButton(PlayerSide side, BuildContext context) {
    return Radio(
      value: side,
      groupValue: context.watch<GameData>().getSide,
      onChanged: (value) {
        if (value == null) return;
        context.read<GameData>().selectSide(value);
      },
      toggleable: true,
    );
  }
}
