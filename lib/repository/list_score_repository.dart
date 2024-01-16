import 'package:rps_game/provider/list_score_provider.dart';

import '../data/user.dart';

class ListScoreRepository {
  final ListScoreProvider listScoreProvider = ListScoreProvider();

  Future<List<User>> getResult() async {
    return await listScoreProvider.readScores();
  }
  Future<void> createNewScore(User user) async {
    return await listScoreProvider.createScore(user);
  }
}
