import 'package:learn_chess_board/assets/constants.dart';

enum PlayerSide { white, black }

extension PlayesSideExtension on PlayerSide {
  String get getLabel {
    switch (this) {
      case PlayerSide.white:
        return I10n.white;
      case PlayerSide.black:
        return I10n.black;
    }
  }
}
