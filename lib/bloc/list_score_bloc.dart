import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rps_game/bloc/list_score_event.dart';
import 'package:rps_game/bloc/list_score_state.dart';
import 'package:rps_game/repository/list_score_repository.dart';

class ListScoreBloc extends Bloc<ListScoreEvent, ListScoreState> {
  final ListScoreRepository _listScoreRepository = ListScoreRepository();

  ListScoreBloc() : super(ListScoreInitialState()) {
    on<GetScoreList>((event, emit) async {
      emit(ListScoreLoadingState());
      try {
        final data = await _listScoreRepository.getResult();
        emit(ListScoreSuccessState(listScore: data));
      } on Exception catch (e) {
        emit(ListScoreFailedState(error: e.toString()));
      }
    });
    on<AddNewScore>((event, emit) async {
      await _listScoreRepository.createNewScore(event.user);
      emit(ListScoreLoadingState());
      try {
        final data = await _listScoreRepository.getResult();
        emit(ListScoreSuccessState(listScore: data));
      } on Exception catch (e) {
        emit(ListScoreFailedState(error: e.toString()));
      }
    });
  }
}
