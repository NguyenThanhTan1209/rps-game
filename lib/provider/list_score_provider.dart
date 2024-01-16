import 'package:path/path.dart';
import 'package:rps_game/data/user.dart';
import 'package:sqflite/sqflite.dart';

class ListScoreProvider {
  String gameScoreDatabaseName = 'keo_bua_bao.db';
  String tableGameScoreName = 'gamescore';
  String createDatabaseQuery =
      'CREATE TABLE gamescore(id INTERGER PRIMARY KEY, userName TEXT, point INTEGER, createDate TEXT)';
  int firstVersionDatabase = 1;

  Future<Database> _getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), gameScoreDatabaseName),
        onCreate: (db, version) {
      return db.execute(createDatabaseQuery);
    }, version: firstVersionDatabase);
  }

  Future<List<User>> readScores() async {
    final database = await _getDatabase();
    final List<Map<String, dynamic>> maps = await database.query(tableGameScoreName, orderBy: 'point DESC, createDate DESC');

    return List.generate(maps.length, (index) {
      return User.fromJson(maps[index]);
    });
  }

  Future<void> createScore(User user) async {
    final database = await _getDatabase();
    await database.insert(tableGameScoreName, user.toMap());
  }
}
