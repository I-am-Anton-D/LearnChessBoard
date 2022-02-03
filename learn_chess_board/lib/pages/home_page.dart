import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/service/game_engine.dart';
import 'package:learn_chess_board/widgets/chess_board.dart';
import 'package:learn_chess_board/widgets/enums/field_label_type.dart';
import 'package:learn_chess_board/widgets/enums/player_side.dart';
import 'dart:async';

//Home Page class
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool _started = false;
  int _fails = 0;
  int _passed = 0;
  String _youPick = "";
  String _nextField = "";
  FieldLabelType _selectedRadioGroupType = FieldLabelType.full;
  PlayerSide _selectedPlayerSide = PlayerSide.white;
  int _startTimer = 0;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: COMMON_BACKGROUND,
        padding: const EdgeInsets.all(DIM_BODY_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChessBoard(_selectedRadioGroupType, _selectedPlayerSide,
                (index, pick) => _onFieldPress(index, pick)),
            if (!_started) ...[
              _buildFieldLabelRadioGroup(),
              _buildPlayerSideRadioGroup()
            ] else ...[
              _buildGameTv()
            ],
            _buildStartButton()
          ],
        ),
      ),
    );
  }

  Expanded _buildStartButton() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
            onPressed: () {
              _onStartButton();
            },
            child: Container(
                decoration: BoxDecoration(
                    color: BUTTON_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                child: Text(
                  _started ? "STOP" : "START",
                  style: const TextStyle(
                      color: BUTTON_TEXT_COLOR, fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }

  //Create select label type Radio Group
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

  //Create label type Radio Button
  Radio<FieldLabelType> _buildFieldLabelRadioButton(FieldLabelType typeValue) {
    return Radio(
      value: typeValue,
      groupValue: _selectedRadioGroupType,
      onChanged: (value) {
        if (value == null) return;
        _onSelectedLabelRadioGroupClick(value);
      },
      toggleable: true,
    );
  }

  //On select type Radio Button click
  _onSelectedLabelRadioGroupClick(FieldLabelType type) {
    setState(() {
      _selectedRadioGroupType = type;
    });
  }

  //Create player side Radio Group
  Column _buildPlayerSideRadioGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(left: DIM_MEDIUM_PADDING),
            child: const Text(SELECT_SIDE)),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _buildPlayerSideRadioButton(PlayerSide.white),
          const Text('WHITE'),
          _buildPlayerSideRadioButton(PlayerSide.black),
          const Text('BLACK')
        ]),
      ],
    );
  }

  //Select player side Radio button
  Radio<PlayerSide> _buildPlayerSideRadioButton(PlayerSide side) {
    return Radio(
      value: side,
      groupValue: _selectedPlayerSide,
      onChanged: (value) {
        if (value == null) return;
        _onSelectedSideRadioGroupClick(value);
        _selectedPlayerSide = value;
      },
      toggleable: true,
    );
  }

  //On select player side Radio Button click
  void _onSelectedSideRadioGroupClick(PlayerSide value) {
    setState(() {
      _selectedPlayerSide = value;
    });
  }

  _onStartButton() {
    setState(() {
      if (_started == true) {
        _started = false;
        _timer.cancel();
        _startTimer = 0;
      } else {
        startTimer();
        _fails = 0;
        _passed = 0;
        _nextField = GameEngine.nextField();
        _started = true;
        _youPick = "";
      }
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _startTimer++;
        },
      ),
    );
  }

  Row _buildGameTv() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: GREY_BACKGROUD_COLOR,
              borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.only(left: 10, top: 15),
          child: Text(
            _nextField,
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Time: $_startTimer'),
              Container(height: 10),
              Text('Correct count: $_passed',
                  style: const TextStyle(color: Colors.green)),
              Container(height: 10),
              Text('Fails count: $_fails',
                  style: const TextStyle(color: Colors.red)),
              Container(height: 10),
              Text('You pick: $_youPick',
                  style: const TextStyle(color: Colors.yellow))
            ],
          ),
        )
      ],
    );
  }

  _onFieldPress(int index, String youPick) {
    if (!_started) return;
    setState(() {
      if (GameEngine.validate(index, _selectedPlayerSide)) {
        _passed++;
      } else {
        _fails++;
      }
      _youPick = youPick;
      _nextField = GameEngine.nextField();
    });
  }
}
