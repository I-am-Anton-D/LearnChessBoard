import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:provider/provider.dart';

import 'enums/field_label_type.dart';

class FieldLabelTypeSelector extends StatelessWidget {
  const FieldLabelTypeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(left: DIM_MEDIUM_PADDING, top: DIM_MEDIUM_PADDING),
            child: const Text(SELECT_BOARD_LABEL)),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _buildFieldLabelRadioButton(FieldLabelType.full, context),
          const Text('FULL'),
          _buildFieldLabelRadioButton(FieldLabelType.firstLine, context),
          const Text('FIRST LINE'),
          _buildFieldLabelRadioButton(FieldLabelType.none, context),
          const Text('NONE')
        ])
      ],
    );
  }

  //Create label type Radio Button
  Radio<FieldLabelType> _buildFieldLabelRadioButton(FieldLabelType typeValue,
      BuildContext context) {
    return Radio(
      value: typeValue,
      groupValue: context
          .watch<GameData>()
          .getLabelType,
      onChanged: (value) {
        if (value == null) return;
        context.read<GameData>().selectType(value);
      },
      toggleable: true,
    );
  }

}
