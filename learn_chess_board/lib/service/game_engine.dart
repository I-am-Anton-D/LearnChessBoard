import 'dart:math';

import 'package:learn_chess_board/widgets/enums/player_side.dart';

class GameEngine {
  static Random random = Random();
  static int index = -1;

  static int getRandomField() {
    return random.nextInt(63);
  }

  static String getFieldLabel() {
    int row = index ~/ 8;
    int column = index - row * 8;

    String columnLabel = String.fromCharCode('A'.codeUnitAt(0) + column);
    String rowLabel = (7 - row + 1).toString();

    return columnLabel + rowLabel;
  }

  static String nextField() {
    index = getRandomField();
    return getFieldLabel();
  }

  static bool validate(int pickFieldIndex, PlayerSide selectedPlayerSide) {
    if (selectedPlayerSide == PlayerSide.white) {
      return pickFieldIndex == index;
    } else {
      return 63 - pickFieldIndex == index;
    }
  }
}