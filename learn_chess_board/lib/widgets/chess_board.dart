import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/widgets/enums/field_label_type.dart';

import 'enums/player_side.dart';
import 'field.dart';

class ChessBoard extends StatelessWidget {
  late FieldLabelType labelType;
  late PlayerSide playerSide;
  late Function(int, String) fieldPressHolder;

  ChessBoard(FieldLabelType type, PlayerSide side, Function(int, String) pressHolder) {
    labelType = type;
    playerSide = side;
    fieldPressHolder = pressHolder;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 64,
      itemBuilder: (BuildContext context, int index) =>
         Field(index, labelType, playerSide, fieldPressHolder),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
    );
  }
}