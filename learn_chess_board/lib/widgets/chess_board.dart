import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/widgets/field_label_type.dart';

import 'field.dart';

class ChessBoard extends StatelessWidget {
  late FieldLabelType labelType;

  ChessBoard(FieldLabelType type) {
    labelType = type;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 64,
      itemBuilder: (BuildContext context, int index) =>
         Field(index, labelType),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
    );
  }
}