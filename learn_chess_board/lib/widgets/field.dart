import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'enums/field_label_type.dart';
import 'enums/player_side.dart';

class Field extends StatelessWidget {
  late final index;
  late final int row;
  late final int column;
  late final FieldLabelType labelType;
  late final PlayerSide playerSide;
  late final bool isBlack;
  late final Function(int, String) fieldPressHolder;
  late final String label;

  Field(int idx, FieldLabelType type, PlayerSide side,
      Function(int, String) pressHolder) {
    index = idx;
    row = index ~/ 8;
    column = index - row * 8;
    labelType = type;
    isBlack = _isBlack();
    playerSide = side;
    fieldPressHolder = pressHolder;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => fieldPressHolder(index, _getFieldLabel()),
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero, alignment: Alignment.center),
      child: Container(
        padding: const EdgeInsets.all(DIM_FIELD_PADDING),
        color: _getColorForField(),
        child: _buildFieldLabel(),
        alignment: _getAlignment(),
      ),
    );
  }

  Color _getColorForField() => isBlack ? BLACK_COLOR : WHITE_COLOR;

  Color _getColorForText() => isBlack ? WHITE_COLOR : BLACK_COLOR;

  bool _isBlack() {
    return (_isColumnIndexEven(column) && !_isRowIndexEven(row)) ||
        (!_isColumnIndexEven(column) && _isRowIndexEven(row));
  }

  bool _isColumnIndexEven(int col) {
    return col % 2 == 0;
  }

  bool _isRowIndexEven(int row) {
    return row % 2 == 0;
  }

  Widget _buildFieldLabel() {
    return Text(
      _getTextForFieldLabel(),
      style: TextStyle(color: _getColorForText()),
    );
  }

  String _getFieldLabel() {
    String columnLabel = "";
    String rowLabel = "";
    if (playerSide == PlayerSide.white) {
      columnLabel = String.fromCharCode('A'.codeUnitAt(0) + column);
      rowLabel = (7 - row + 1).toString();
    } else {
      columnLabel = String.fromCharCode('H'.codeUnitAt(0) - column);
      rowLabel = (row + 1).toString();
    }
    return columnLabel + rowLabel;
  }

  String _getTextForFieldLabel() {
    String label = "";
    String columnLabel = "";
    String rowLabel = "";

    if (playerSide == PlayerSide.white) {
      columnLabel = String.fromCharCode('A'.codeUnitAt(0) + column);
      rowLabel = (7 - row + 1).toString();
    } else {
      columnLabel = String.fromCharCode('H'.codeUnitAt(0) - column);
      rowLabel = (row + 1).toString();
    }

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

  Alignment _getAlignment() {
    return labelType == FieldLabelType.firstLine
        ? Alignment.bottomLeft
        : Alignment.center;
  }
}
