import 'package:rps_game/data/game_match.dart';

abstract class GameEvent {
  GameChoice gameChoice;
  GameEvent({
    required this.gameChoice,
  });
}

class ChooseOptionEvent extends GameEvent {
  ChooseOptionEvent({required super.gameChoice});
}
