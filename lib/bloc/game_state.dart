// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rps_game/data/game_match.dart';

abstract class GameState {
  GameMatch gameMatch;
  GameState({
    required this.gameMatch,
  });
}

class GameInitialState extends GameState {
  GameInitialState():super(gameMatch: GameMatch(myChoice: GameChoice.paper, opponentChoice: GameChoice.paper, result: 'none'));
}
class GameWinState extends GameState {
  GameWinState({required super.gameMatch});
}
class GameDueState extends GameState {
  GameDueState({required super.gameMatch});
}
class GameLoseState extends GameState {
  GameLoseState({required super.gameMatch});
}
