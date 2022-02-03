import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/widgets/chess_board.dart';
import 'package:learn_chess_board/widgets/field_label_type.dart';

//Home Page class
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: COMMON_BACKGROUND,
          padding: const EdgeInsets.all(DIM_BODY_PADDING),
          child: Column(
            children: [
              const Text('Timer'),
              ChessBoard(FieldLabelType.full),
              const Text('Radio')
            ],
          ),
        ),
      );
  }
}