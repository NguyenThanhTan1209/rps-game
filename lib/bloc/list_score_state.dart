// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../data/user.dart';

abstract class ListScoreState {
  
}

class ListScoreInitialState extends ListScoreState {
  List<User> listScore = [];
}

class ListScoreLoadingState extends ListScoreState {
  
}

class ListScoreSuccessState extends ListScoreState {
  List<User> listScore;
  ListScoreSuccessState({
    required this.listScore,
  });
}

class ListScoreFailedState extends ListScoreState {
  String error;
  ListScoreFailedState({
    required this.error,
  });
}
