import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/widgets/field_label_type.dart';

class Field extends StatelessWidget {
  late final int row;
  late final int column;
  late final FieldLabelType labelType;
  late final bool isBlack;

  Field(int index, FieldLabelType type) {
    row = index ~/ 8;
    column = index - row * 8;
    labelType = type;
    isBlack = _isBlack();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DIM_FIELD_PADDING),
      color: _getColorFofField(),
      child: _buildFieldLabel(labelType),
      alignment: _getAlignment(labelType),
    );
  }

  Color _getColorFofField() => isBlack ? BLACK_COLOR : WHITE_COLOR;
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

  Widget _buildFieldLabel(FieldLabelType labelType) {
    return Text(_getTextForFieldLabel(labelType),
      style: TextStyle(
        color: _getColorForText()
      ),
    );
  }

  String _getTextForFieldLabel(FieldLabelType labelType) {
    String label = "";

    String columnLabel = String.fromCharCode('A'.codeUnitAt(0) + column);
    String rowLabel = (7 - row + 1).toString();

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

  Alignment _getAlignment(FieldLabelType labelType) {
    if (labelType == FieldLabelType.firstLine) {
      return Alignment.bottomLeft;
    }
    return Alignment.center;
  }
}
