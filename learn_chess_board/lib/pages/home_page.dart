import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/widgets/chess_board.dart';
import 'package:learn_chess_board/widgets/field_label_type.dart';

//Home Page class
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  FieldLabelType fieldLabelType = FieldLabelType.full;
  FieldLabelType selectedRadioGroupType = FieldLabelType.full;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: COMMON_BACKGROUND,
        padding: const EdgeInsets.all(DIM_BODY_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChessBoard(fieldLabelType),
            _buildFieldLabelRadioGroup(),
            _buildTimerTimerSeekBar()
          ],
        ),
      ),
    );
  }


  //Create Radio Group
  Column _buildFieldLabelRadioGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(
                left: DIM_MEDIUM_PADDING, top: DIM_MEDIUM_PADDING),
            child: const Text(SELECT_BOARD_LABEL)),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _buildFieldLabelRadioButton(FieldLabelType.full),
          const Text('FULL'),
          _buildFieldLabelRadioButton(FieldLabelType.firstLine),
          const Text('FIRST LINE'),
          _buildFieldLabelRadioButton(FieldLabelType.none),
          const Text('NONE')
        ])
      ],
    );
  }

  //Create Radio Button
  Radio<FieldLabelType> _buildFieldLabelRadioButton(FieldLabelType typeValue) {
    return Radio(
      value: typeValue,
      groupValue: selectedRadioGroupType,
      onChanged: (value) {
        _onRadioGroupClick(value as FieldLabelType);
        selectedRadioGroupType = value;
      },
      toggleable: true,
    );
  }

  //On Radio click
  _onRadioGroupClick(FieldLabelType type) {
    setState(() {
      fieldLabelType = type;
    });
  }

  Column _buildTimerTimerSeekBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(
                left: DIM_MEDIUM_PADDING),
            child: const Text(SELECT_TIMER)),
        const Text('SEEK BAR')
      ],
    );
  }
}
