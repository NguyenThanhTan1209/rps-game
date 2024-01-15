import 'package:rps_game/data/game_match.dart';
import 'package:rps_game/provider/game_provider.dart';

class GameRepository {
  final GameProvider gameProvider = GameProvider();

  Future<GameMatch> getResult(GameChoice gameChoice)async{
    return await gameProvider.gameCalculate(gameChoice);
  }
}