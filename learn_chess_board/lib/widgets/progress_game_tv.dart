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
              BoxDecoration(color: AppColors.greyBackground, borderRadius: BorderRadius.circular(Dims.smallRadius)),
          margin: const EdgeInsets.only(left: Dims.smallPadding, top: Dims.mediumPadding),
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
              Text(I10n.time + context.watch<GameData>().getTimeString),
              const SizedBox(height: 10),
              Text(I10n.correctCount + context.watch<GameData>().getPassed.toString(),
                  style: const TextStyle(color: Colors.green)),
              const SizedBox(height: 10),
              Text(I10n.failsCunt + context.watch<GameData>().getFails.toString(),
                  style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              Text(I10n.youPick +  context.watch<GameData>().getYouPick,
                  style: const TextStyle(color: Colors.yellow))
            ],
          ),
        )
      ],
    );
  }
}
