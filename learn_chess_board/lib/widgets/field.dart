import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:learn_chess_board/service/game_engine.dart';
import 'package:provider/provider.dart';
import 'enums/field_label_type.dart';
import 'enums/player_side.dart';

class Field extends StatelessWidget {
  final int index;
  final FieldLabelType labelType;
  final PlayerSide playerSide;

  late final int column;
  late final int row;
  late final String rowLabel;
  late final String columnLabel;
  late final bool isBlack;

  Field({Key? key, required this.index, required this.labelType, required this.playerSide})
      : super(key: key) {
    row = index ~/ 8;
    column = index - row * 8;
    isBlack = _isBlack();
    _initLabels();
  }

  //Происходит переворот доски, смени меняется цвет игрока
  _initLabels() {
    if (playerSide == PlayerSide.white) {
      columnLabel = String.fromCharCode('A'.codeUnitAt(0) + column);
      rowLabel = (7 - row + 1).toString();
    } else {
      columnLabel = String.fromCharCode('H'.codeUnitAt(0) - column);
      rowLabel = (row + 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onFieldPress(index, _getFieldLabel(), context),
      style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.center),
      child: Container(
        padding: const EdgeInsets.all(Dims.fieldPadding),
        color: isBlack ? AppColors.blackField : AppColors.whiteField,
        child: _buildFieldLabel(),
        alignment: _getAlignment(),
      ),
    );
  }

  _buildFieldLabel() {
    return Text(
      _getTextForFieldLabel(),
      style: TextStyle(color: isBlack ? AppColors.whiteField : AppColors.blackField),
    );
  }

  _isBlack() {
    return (_isColumnIndexEven(column) && !_isRowIndexEven(row)) ||
        (!_isColumnIndexEven(column) && _isRowIndexEven(row));
  }

  _isColumnIndexEven(int col) => col % 2 == 0;
  _isRowIndexEven(int row) => row % 2 == 0;

   _getAlignment() =>
      labelType == FieldLabelType.firstLine ? Alignment.bottomLeft : Alignment.center;

  _getFieldLabel() => columnLabel + rowLabel;


  String _getTextForFieldLabel() {
    String label = "";

    if (labelType == FieldLabelType.full) {
      label = columnLabel + rowLabel;
    }

    if (labelType == FieldLabelType.firstLine) {
      if (row == 7) {
        label = columnLabel;
      }
      if (column == 0) {
        label = rowLabel;
      }
      if (row == 7 && column == 0) {
        label = columnLabel + rowLabel;
      }
    }
    return label;
  }

  //Click on Field
  _onFieldPress(int userPickIndex, String youPick, BuildContext context) {
    var state = context.read<GameData>();
    if (!state.isStarted) return;

    GameEngine.validateUserPick(userPickIndex, state.getSide) ? state.incPassed() : state.incFails();

    state.setPick(youPick);
    state.generateNextField();
  }
}
