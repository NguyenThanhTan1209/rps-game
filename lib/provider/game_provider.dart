import 'dart:math';

import 'package:rps_game/data/game_match.dart';

class GameProvider {
  Future<GameMatch> gameCalculate(GameChoice userChoice) async {
    Random random = Random();
    int position = random.nextInt(GameChoice.values.length-1);
    GameChoice opponentChoice = GameChoice.values[position];

    if (userChoice == opponentChoice) {
      return GameMatch(myChoice: userChoice, opponentChoice: opponentChoice, result: 'Hoà');
    } else if (_caluculateChoice(userChoice, opponentChoice)){
      return GameMatch(myChoice: userChoice, opponentChoice: opponentChoice, result: 'Thắng');
    } else {
      return GameMatch(myChoice: userChoice, opponentChoice: opponentChoice, result: 'Thua');
    }
    
  }

  bool _caluculateChoice(GameChoice userChoice, GameChoice opponentChoice){
    return (userChoice == GameChoice.scissors && opponentChoice == GameChoice.paper) || 
    (userChoice == GameChoice.paper && opponentChoice == GameChoice.rock) || 
    (userChoice == GameChoice.rock && opponentChoice == GameChoice.scissors);
  }
}

// add comment
// commit in test
// commit in develop
// commit in staging