import 'package:english_words/english_words.dart';
import 'package:sqflite/sqflite.dart';

String _tableName = 'WordPair';
String _columnId = 'id';
String _columnFirst = 'first';
String _columnSecond = 'second';
String _columnSaved = 'saved';

class WordPairData {
  int id;
  WordPair pair;
  bool saved;

  WordPairData(this.pair, this.saved);

  Map<String, dynamic> toMap() => {
        _columnFirst: pair.first,
        _columnSecond: pair.second,
        _columnSaved: saved == true ? 1 : 0
      };

  WordPairData.fromMap(Map<String, dynamic> map) {
    id = map[_columnId];
    pair = WordPair(map[_columnFirst], map[_columnSecond]);
    saved = map[_columnSaved] == 1;
  }
}

class PersistentWordPairProvider {
  Database db;

  PersistentWordPairProvider();

  Future _open() async {
    final databasesPath = await getDatabasesPath();
    String path = '$databasesPath/my_db.db';
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        return await db.execute(
          '''
          create table $_tableName ( 
            $_columnId integer primary key autoincrement, 
            $_columnFirst text not null,
            $_columnSecond text not null,
            $_columnSaved integer not null)
          ''',
        );
      },
    );
  }

  Future<List<int>> batchInsert(List<WordPairData> pairs) async {
    await _open();
    final batch = db.batch();
    pairs.forEach((pair) {
      batch.insert(_tableName, pair.toMap());
    });
    final result = await batch.commit();
    print('Result of batch insert: $result');
    await _close();
    return result
        .toList()
        .map(
          (item) => int.parse(item.toString()),
        )
        .toList();
  }

  Future<List<WordPairData>> getAll() async {
    await _open();
    List<Map> maps = await db.rawQuery(
      'SELECT * FROM $_tableName ORDER BY $_columnId',
    );
    List<WordPairData> result = [];
    if (maps.length > 0) {
      result = maps.map((map) => WordPairData.fromMap(map)).toList();
    }
    await _close();
    return result;
  }

  Future<List<WordPairData>> getDataWithIDs(List<int> idList) async {
    await _open();
    List<Map> maps = await db.rawQuery(
      """
      SELECT * 
      FROM $_tableName 
      WHERE $_columnId IN (${idList.join(', ')})
      ORDER BY $_columnId
      """,
    );
    List<WordPairData> result = [];
    if (maps.length > 0) {
      result = maps.map((map) => WordPairData.fromMap(map)).toList();
    }
    await _close();
    return result;
  }

  Future<int> updateSaved(WordPairData data) async {
    await _open();
    var result = await db.rawUpdate("""
        UPDATE $_tableName 
        SET $_columnSaved = ${data.saved ? '1' : '0'} 
        WHERE $_columnId = ${data.id}
        """);
    await _close();
    print('Result of updateSaved: $result');
    return result;
  }

  Future _close() async => db.close();
}
