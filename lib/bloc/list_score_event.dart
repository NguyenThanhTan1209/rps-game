// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rps_game/data/user.dart';

abstract class ListScoreEvent {
  
}

class GetScoreList extends ListScoreEvent {
  
}

class AddNewScore extends ListScoreEvent {
  User user;
  AddNewScore({
    required this.user,
  });
}
