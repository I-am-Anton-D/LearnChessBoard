import 'package:flutter/material.dart';
import 'package:learn_chess_board/widgets/enums/field_label_type.dart';
import 'package:learn_chess_board/widgets/enums/player_side.dart';

class GameData with ChangeNotifier {
  FieldLabelType _selectedLabelType = FieldLabelType.full;
  PlayerSide _selectedPlayerSide = PlayerSide.white;

  FieldLabelType get getLabelType => _selectedLabelType;
  PlayerSide get getSide => _selectedPlayerSide;

  selectType(FieldLabelType type) {
    _selectedLabelType = type;
    notifyListeners();
  }

  selectSide(PlayerSide side) {
    _selectedPlayerSide = side;
    notifyListeners();
  }

}