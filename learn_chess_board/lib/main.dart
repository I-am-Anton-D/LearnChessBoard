import 'package:flutter/material.dart';
import 'package:learn_chess_board/pages/home_page.dart';
import 'assets/constants.dart';

//Entry Point
void main() => runApp(const LearnChessBoard());

//Main class
class LearnChessBoard extends StatelessWidget {
  const LearnChessBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          unselectedWidgetColor: TEXT_COLOR,
          toggleableActiveColor: Colors.red,
          textTheme: const TextTheme(
            bodyText2: TextStyle(
              color: TEXT_COLOR,
            ),
          ),
        ),
        home: const HomePage());
  }
}
