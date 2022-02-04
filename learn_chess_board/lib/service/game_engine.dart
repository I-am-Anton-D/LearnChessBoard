import 'dart:math';
import 'package:learn_chess_board/widgets/enums/player_side.dart';

class GameEngine {
  static Random random = Random();
  static int randomFieldIndex = -1;

  static int getRandomField() => random.nextInt(63);

  static String getFieldLabel() {
    int row = randomFieldIndex ~/ 8;
    int column = randomFieldIndex - row * 8;

    String columnLabel = String.fromCharCode('A'.codeUnitAt(0) + column);
    String rowLabel = (7 - row + 1).toString();

    return columnLabel + rowLabel;
  }

  static String nextField() {
    randomFieldIndex = getRandomField();
    return getFieldLabel();
  }

  //Если выбран черный цвет, то инвертируем индекс на 63, на поле 64 клетки
  static bool validateUserPick(int pickFieldIndex, PlayerSide selectedPlayerSide) {
    return selectedPlayerSide == PlayerSide.white
        ? pickFieldIndex == randomFieldIndex
        : 63 - pickFieldIndex == randomFieldIndex;
  }
}
