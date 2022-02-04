//Enum for chessboard fields labels
import 'package:learn_chess_board/assets/constants.dart';

enum FieldLabelType {
  full,
  firstLine,
  none
}

extension FieldLabelTypeExtension on FieldLabelType {
  String get getLabel {
    switch (this) {
      case FieldLabelType.none:
        return I10n.labelTypeNone;
      case FieldLabelType.full:
        return I10n.labelTypeFull;
      case FieldLabelType.firstLine:
        return I10n.labelTypeFirstLine;
    }
  }
}