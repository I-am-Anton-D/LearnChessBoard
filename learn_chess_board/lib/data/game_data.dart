import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn_chess_board/service/game_engine.dart';
import 'package:learn_chess_board/utils/text_utils.dart';
import 'package:learn_chess_board/widgets/enums/field_label_type.dart';
import 'package:learn_chess_board/widgets/enums/player_side.dart';

class GameData with ChangeNotifier {
  FieldLabelType _selectedLabelType = FieldLabelType.full;
  PlayerSide _selectedPlayerSide = PlayerSide.white;
  bool _started = false;
  int _passed = 0;
  int _fails = 0;
  int _gameSeconds = 0;

  String _nextField = GameEngine.nextField();
  String _youPick = "";
  String _timeString = "00:00";

  FieldLabelType get getLabelType => _selectedLabelType;
  PlayerSide get getSide => _selectedPlayerSide;
  bool get isStarted => _started;
  int get getPassed => _passed;
  int get getFails => _fails;
  String get getNextField => _nextField;
  String get getYouPick => _youPick;
  String get getTimeString => _timeString;

  Timer? _timer;

  _updateTimeString() {
    _timeString = TextUtils.getTimeString(_gameSeconds);
    notifyListeners();
  }

  setPick(String pick) {
    _youPick = pick;
  }

  generateNextField() {
    _nextField = GameEngine.nextField();
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

  startGame() {
    _started = true;
    _gameSeconds = 0;
    _timeString = "00:00";
    startTimer();
    notifyListeners();
  }

  stopGame() {
    _timer?.cancel();
    _started = false;
    notifyListeners();
  }

  selectType(FieldLabelType type) {
    _selectedLabelType = type;
    notifyListeners();
  }

  selectSide(PlayerSide side) {
    _selectedPlayerSide = side;
    notifyListeners();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
            _gameSeconds++;
            _updateTimeString();
          }
    );
  }
}