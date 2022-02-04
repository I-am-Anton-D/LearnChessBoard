import 'package:flutter/material.dart';
import 'package:learn_chess_board/assets/constants.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:learn_chess_board/service/game_engine.dart';
import 'package:learn_chess_board/widgets/chess_board.dart';
import 'package:learn_chess_board/widgets/enums/field_label_type.dart';
import 'package:learn_chess_board/widgets/enums/player_side.dart';
import 'dart:async';

import 'package:provider/provider.dart';

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
  String _timeString = "00:00";
  int _startTimer = 0;

  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: COMMON_BACKGROUND,
        padding: const EdgeInsets.all(DIM_BODY_PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChessBoard(fieldPressHolder: _onFieldPress),
            Wrap(children: [
              if (!_started) ...[_buildFieldLabelRadioGroup(), _buildPlayerSideRadioGroup()] else
                _buildGameTv()
            ]),
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
                    color: BUTTON_BACKGROUND_COLOR, borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                child: Text(
                  _started ? "STOP" : "START",
                  style: const TextStyle(color: BUTTON_TEXT_COLOR, fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.only(left: DIM_MEDIUM_PADDING, top: DIM_MEDIUM_PADDING),
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
      groupValue: context.watch<GameData>().getLabelType,
      onChanged: (value) {
        if (value == null) return;
        context.read<GameData>().selectType(value);
      },
      toggleable: true,
    );
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
      groupValue: context.watch<GameData>().getSide,
      onChanged: (value) {
        if (value == null) return;
        context.read<GameData>().selectSide(value);
      },
      toggleable: true,
    );
  }

  _onStartButton() {
    setState(() {
      if (_started == true) {
        _started = false;
        _timer.cancel();
        _startTimer = 0;
        showAlertDialog(context);
      } else {
        startTimer();
        _timeString = "00:00";
        _fails = 0;
        _passed = 0;
        _nextField = GameEngine.nextField();
        _started = true;
        _youPick = "";
      }
    });
  }

  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: COMMON_BACKGROUND,
      title: const Text("Training over", style: TextStyle(color: Colors.white)),
      content: Text('''
Full time: $_timeString  
Passed count: $_passed
Fail count: $_fails ''', style: const TextStyle(color: Colors.white)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _startTimer++;
          _timeString = getTimeString();
        },
      ),
    );
  }

  Row _buildGameTv() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110,
          width: 110,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: GREY_BACKGROUD_COLOR, borderRadius: BorderRadius.circular(5)),
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
              Text('Time: $_timeString'),
              Container(height: 10),
              Text('Correct count: $_passed', style: const TextStyle(color: Colors.green)),
              Container(height: 10),
              Text('Fails count: $_fails', style: const TextStyle(color: Colors.red)),
              Container(height: 10),
              Text('You pick: $_youPick', style: const TextStyle(color: Colors.yellow))
            ],
          ),
        )
      ],
    );
  }

  _onFieldPress(int index, String youPick) {
    if (!_started) return;
    setState(() {
      if (GameEngine.validate(index, context.watch<GameData>().getSide)) {
        _passed++;
      } else {
        _fails++;
      }
      _youPick = youPick;
      _nextField = GameEngine.nextField();
    });
  }

  String getTimeString() {
    final duration = Duration(seconds: _startTimer);
    final minutes = duration.inMinutes;
    final seconds = _startTimer % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}
