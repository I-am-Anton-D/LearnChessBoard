import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn_chess_board/service/game_engine.dart';
import 'package:learn_chess_board/utils/text_utils.dart';
import 'package:learn_chess_board/widgets/enums/field_label_type.dart';
import 'package:learn_chess_board/widgets/enums/player_side.dart';

//Game State
class GameData with ChangeNotifier {
  FieldLabelType _selectedLabelType = FieldLabelType.full;    //FULL, FIRST LINE, NONE
  PlayerSide _selectedPlayerSide = PlayerSide.white;          //WHITE, BLACK
  bool _started = false;
  int _passed = 0;                                            //Correct answers in game
  int _fails = 0;                                             //Not correct answers
  String _nextField = GameEngine.nextField();                 //Random game field
  String _youPick = "";                                       //User pick
  String _timeString = "00:30";                               //Show time string

  //Getters for private fields
  FieldLabelType get getLabelType => _selectedLabelType;
  PlayerSide get getSide => _selectedPlayerSide;
  bool get isStarted => _started;
  int get getPassed => _passed;
  int get getFails => _fails;
  String get getNextField => _nextField;
  String get getYouPick => _youPick;
  String get getTimeString => _timeString;

  startGame() {
    _started = true;
    _timeString = "00:30";
    notifyListeners();
  }

  stopGame() {
    _started = false;
    notifyListeners();
  }

  reset() {
    _started = false;
    _passed = 0;
    _fails = 0;
    _youPick = "";
    _nextField = GameEngine.nextField();
    notifyListeners();
  }

  incPassed() {
    _passed++;
    notifyListeners();
  }

  incFails() {
    _fails++;
    notifyListeners();
  }

  setPick(String pick) => _youPick = pick;

  selectType(FieldLabelType type) {
    _selectedLabelType = type;
    notifyListeners();
  }

  selectSide(PlayerSide side) {
    _selectedPlayerSide = side;
    notifyListeners();
  }

  generateNextField() => _nextField = GameEngine.nextField();

  updateTimeString(int gameSeconds) {
    _timeString = TextUtils.getTimeString(gameSeconds);
    notifyListeners();
  }
}
