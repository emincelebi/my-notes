import 'package:my_notes/model/notes_model.dart';
import 'package:my_notes/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabaseHelper {
  static Database? _database;
  static const String noteDBName = 'notes';
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
    final databasePath = join(path, "$noteDBName.db");
    Database db = await openDatabase(databasePath, version: _version, onCreate: _createDB);

    return db;
  }

  _createDB(Database db, int newVersion) async {
    await db.execute('''
          CREATE TABLE $noteDBName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            date TEXT,
            userId INTEGER
          )
        ''');
  }

  Future<List<NoteModel>> getNotes(UserModel? user) async {
    Database db = await database;

    var res =  user != null ? await db.query(noteDBName, where: "userId = ?", whereArgs: [user.id]) :await db.query(noteDBName);

    List<NoteModel> notes = res.isNotEmpty ? res.map((e) => NoteModel.fromJson(e)).toList():[];

    return notes;
  }

  Future<int> insert(NoteModel note) async {
    final db = await database;
    return await db.insert(noteDBName, note.toJson());
  }

  Future<int> update(NoteModel note, UserModel user) async {
    final db = await database;
    return await db.update(noteDBName, note.toJson(), where: "id = ?", whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return db.delete(noteDBName, where: "id = ?", whereArgs: [id]);
  }
}
