import 'package:flutter/material.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:learn_chess_board/widgets/player_side_selector.dart';
import 'package:learn_chess_board/widgets/progress_game_tv.dart';
import 'package:provider/provider.dart';
import 'field_label_type_selector.dart';

class GameTv extends StatelessWidget {
  const GameTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      if (!context.watch<GameData>().isStarted) ...[
        const FieldLabelTypeSelector(),
        const PlayerSideSelector()
      ] else
        const ProgressGameTV()
    ]);
  }
}
