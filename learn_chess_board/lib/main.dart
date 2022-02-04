import 'package:flutter/material.dart';
import 'package:learn_chess_board/data/game_data.dart';
import 'package:learn_chess_board/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'assets/constants.dart';

//Entry Point
void main() => runApp(const LearnChessBoard());

//Main class
class LearnChessBoard extends StatelessWidget {
  const LearnChessBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameData>(
      create: (BuildContext context) => GameData(),
      child: MaterialApp(
          title: I10n.appName,
          theme: _getAppTheme(),
          home: const HomePage()),
    );
  }

  //App theme
  ThemeData _getAppTheme() {
    return ThemeData(
      unselectedWidgetColor: AppColors.commonText,
      toggleableActiveColor: Colors.red,
      primarySwatch: Colors.amber,
      textTheme: const TextTheme(
        bodyText2: TextStyle(
          color: AppColors.commonText,
        ),
      ),
    );
  }
}
