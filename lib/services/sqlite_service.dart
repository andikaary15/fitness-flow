import 'package:fitness_flow/model/user_model.dart';
import 'package:fitness_flow/services/fitness_flow_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqliteService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'sqlite_fitness_flow.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async => await FitnessFlowDB().createTable(database);

}