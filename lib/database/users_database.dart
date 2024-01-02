import 'package:my_notes/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabaseHelper {
  static Database? _database;
  static const String userDBName = 'users';
  final int _version = 1;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, "$userDBName.db");
    Database db = await openDatabase(databasePath, version: _version, onCreate: _createDB);

    return db;
  }

  _createDB(Database db, int newVersion) async {
    await db.execute('''
          CREATE TABLE $userDBName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
        ''');
  }

  Future<List<UserModel>> getUsers(int id) async {
    Database db = await database;

    var res = id != null ? await db.query(userDBName, where: "id = ?", whereArgs: [id]) : await db.query(userDBName);

    List<UserModel> users = res.isNotEmpty ? res.map((e) => UserModel.fromJson(e)).toList() : [];

    return users;
  }

  Future<int> insert(UserModel user) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [user.username, user.password],
    );
    if (result.isEmpty) {
      return await db.insert(userDBName, user.toJson());
    }

    return -1;
  }

  Future<int> update(UserModel user) async {
    final db = await database;
    return await db.update(userDBName, user.toJson(), where: "id = ?", whereArgs: [user.id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return db.delete(userDBName, where: "id = ?", whereArgs: [id]);
  }

  Future<int> getId(String username) async {
    final db = await database;

    var res = await db.query(userDBName, where: "username like ?", whereArgs: [username]);

    if (res.isNotEmpty) {
      return res.first['id'] as int;
    }
    return 0;
  }

  Future<bool> loginUser(String username, String password) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }
}
