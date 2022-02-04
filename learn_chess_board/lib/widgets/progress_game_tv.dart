import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:provider/provider.dart';

class ProgressGameTV extends StatelessWidget {
  const ProgressGameTV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110,
          width: 110,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: GREY_BACKGROUD_COLOR, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.only(left: 10, top: 15),
          child: Text(
            context.watch<GameData>().getNextField,
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Time: '),
              Container(height: 10),
              Text('Correct count:  ${context.watch<GameData>().getPassed}',
                  style: const TextStyle(color: Colors.green)),
              Container(height: 10),
              Text('Fails count:  ${context.watch<GameData>().getFails}',
                  style: const TextStyle(color: Colors.red)),
              Container(height: 10),
              Text('You pick: ${context.watch<GameData>().getYouPick}',
                  style: const TextStyle(color: Colors.yellow))
            ],
          ),
        )
      ],
    );
  }
}
