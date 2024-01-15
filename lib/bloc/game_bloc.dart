import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rps_game/bloc/game_event.dart';
import 'package:rps_game/bloc/game_state.dart';
import 'package:rps_game/repository/game_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameRepository gameRepository = GameRepository();

  GameBloc() : super(GameInitialState()){
    on<ChooseOptionEvent>((event, emit) async {
      final data = await gameRepository.getResult(event.gameChoice);
      if (data.result.contains('Thắng')) {
        emit(GameWinState(gameMatch: data));
      } else if (data.result.contains('Thua')){
        emit(GameLoseState(gameMatch: data));
      } else{
        emit(GameDueState(gameMatch: data));
      }
    });
  }
}