import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:provider/provider.dart';

import 'enums/field_label_type.dart';

//Radio group selector for filed label
class FieldLabelTypeSelector extends StatelessWidget {
  const FieldLabelTypeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(left: Dims.mediumPadding, top: Dims.mediumPadding),
            child: const Text(I10n.selectBoardLabel)),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ...FieldLabelType.values.map((it) =>_buildFieldLabelRadioButton(it, it.getLabel, context)),
        ])
      ],
    );
  }

  //Create label type Radio Button
  Widget _buildFieldLabelRadioButton(FieldLabelType typeValue,
      String radioLabel, BuildContext context) {
    return Row(children: [
      Radio(
        value: typeValue,
        groupValue: context.watch<GameData>().getLabelType,
        onChanged: (value) => context.read<GameData>().selectType(value as FieldLabelType)
      ),
      Text(radioLabel)
    ]);
  }
}
