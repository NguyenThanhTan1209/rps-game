// ignore_for_file: public_member_api_docs, sort_constructors_first
class GameMatch {
  GameChoice myChoice;
  GameChoice opponentChoice;
  String result;
  GameMatch({
    required this.myChoice,
    required this.opponentChoice,
    required this.result,
  });
}

enum GameChoice { paper, rock, scissors, none }
