import 'package:fitness_flow/flutter_flow/flutter_flow_util.dart';
import 'package:fitness_flow/model/kalori_user.dart';
import 'package:fitness_flow/model/meal.dart';
import 'package:fitness_flow/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fitness_flow/services/sqlite_service.dart';

class FitnessFlowDB {

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS "berat_users" ("id" integer,"user_id" INTEGER,"tanggal" datetime,"berat" decimal(15,2),"foto" text,"created_at" datetime NOT NULL,"updated_at" datetime, PRIMARY KEY ("id" AUTOINCREMENT));""");
    await database.execute("""CREATE TABLE IF NOT EXISTS "kalori_users" ("id" integer,"user_id" integer,"tanggal" datetime,"minat" varchar,"berat" decimal(15,2),"kalori" decimal(15,2),"created_at" datetime NOT NULL,"updated_at" datetime, "meal_id" INTEGER, PRIMARY KEY ("id" AUTOINCREMENT));""");
    await database.execute("""CREATE TABLE IF NOT EXISTS "meals" ("id" integer,"nama" varchar,"berat" decimal(15,2),"kalori" decimal(15,2),"created_at" datetime NOT NULL,"updated_at" datetime, "gambar" text, "deskripsi" TEXT, "type" varchar, PRIMARY KEY ("id" AUTOINCREMENT));""");
    await database.execute("""CREATE TABLE IF NOT EXISTS "minat_users" ("id" integer,"user_id" INTEGER,"minat" varchar,"created_at" datetime NOT NULL,"updated_at" datetime, PRIMARY KEY ("id" AUTOINCREMENT));""");
    await database.execute("""CREATE TABLE IF NOT EXISTS "step_users" ("id" integer,"user_id" INTEGER,"tanggal" datetime,"step" integer,"created_at" datetime NOT NULL,"updated_at" datetime, PRIMARY KEY ("id" AUTOINCREMENT));""");
    await database.execute("""CREATE TABLE IF NOT EXISTS "users" ("id" integer,"username" varchar,"password" varchar,"berat" decimal(15,2),"berat_old" decimal(15,2),"tinggi" decimal(15,2),"umur" varchar,"type_berat" varchar,"target_berat" decimal(15,2),"foto" text,"created_at" datetime,"updated_at" datetime, "kaloriharian" decimal(15,2), "aktivitas" decimal(15,4), "jeniskelamin" varchar, PRIMARY KEY ("id" AUTOINCREMENT));""");
    await database.execute("""CREATE TABLE IF NOT EXISTS "workout_users" ("id" integer,"user_id" INTEGER,"tanggal" datetime,"status" varchar,"created_at" datetime NOT NULL,"updated_at" datetime,"workout_id" INTEGER, PRIMARY KEY ("id" AUTOINCREMENT));""");
    await database.execute("""CREATE TABLE IF NOT EXISTS "workouts" ("id" integer,"nama" varchar, "type" varchar,"deskripsi" text,"gambar" text,"link" text,"created_at" datetime NOT NULL,"updated_at" datetime, PRIMARY KEY ("id" AUTOINCREMENT));""");
  }

  Future<int> createUser(String username, password) async {
    final database = await SqliteService().database;
    return await database.rawInsert(
      '''INSERT INTO users (username, password, created_at, updated_at) VALUES (?,?,?,?)''',
      [username, password, DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
  }

  Future<int> createMeal(String nama, berat, kalori, gambar, deskripsi, type) async {
    final database = await SqliteService().database;
    return await database.rawInsert(
      '''INSERT INTO meals (nama, berat, kalori, gambar, deskripsi, type, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)''',
      [nama, berat, kalori, gambar, deskripsi, type, DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
  }

  Future<int> createLatihan(String nama, type, deskripsi, gambar, link) async {
    final database = await SqliteService().database;
    return await database.rawInsert(
      '''INSERT INTO workouts (nama, type, deskripsi, gambar, link, created_at, updated_at) VALUES (?,?,?,?,?,?,?)''',
      [nama, type, deskripsi, gambar, link, DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
  }

  Future<int> createKaloriUser(user_id, berat, kalori, minat, meal_id) async {
    final database = await SqliteService().database;
    var test =  await database.rawInsert(
      '''INSERT INTO kalori_users (user_id, berat, kalori, minat, meal_id, tanggal, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)''',
      [user_id, berat, kalori, minat, meal_id, DateFormat('yyyy-MM-dd').format(DateTime.now()), DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
    return test;
  }


  Future<int> createLatihanUser(user_id, workout_id, tanggal) async {
    final database = await SqliteService().database;
    var test =  await database.rawInsert(
      '''INSERT INTO workout_users (user_id, workout_id, tanggal, status, created_at, updated_at) VALUES (?,?,?,?,?,?)''',
      [user_id, workout_id, tanggal, 'belum', DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
    return test;
  }

  Future<int> createStep(user_id, step) async {
    final database = await SqliteService().database;
    var test =  await database.rawInsert(
      '''INSERT INTO step_users (user_id, step, tanggal, created_at, updated_at) VALUES (?,?,?,?,?)''',
      [user_id, step, DateFormat('yyyy-MM-dd').format(DateTime.now()), DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
    return test;
  }

  Future<int> createBeratBadan(user_id, berat, tanggal, foto) async {
    final database = await SqliteService().database;
    var test =  await database.rawInsert(
      '''INSERT INTO berat_users (user_id, berat, tanggal, foto, created_at, updated_at) VALUES (?,?,?,?,?,?)''',
      [user_id, berat, tanggal, foto, DateTime.now().millisecondsSinceEpoch, DateTime.now().millisecondsSinceEpoch]
    );
    return test;
  }

  Future<int> updateUser(int id, String field, String value) async {
    final database = await SqliteService().database;
    return await database.rawUpdate(
      '''UPDATE users SET $field = ?, updated_at = ? WHERE id = ?''',
      [value, DateTime.now().millisecondsSinceEpoch, id]
    );
  }

  Future<int> changeStatusLatihan(int id, String status) async {
    final database = await SqliteService().database;
    return await database.rawUpdate(
      '''UPDATE workout_users SET status = ?, updated_at = ? WHERE id = ?''',
      [status, DateTime.now().millisecondsSinceEpoch, id]
    );
  }


  fetchStepHarian(tanggal) async {
    final database = await SqliteService().database;
    final step = await database.rawQuery(
    '''
      SELECT COALESCE(SUM(step), 0) AS total_steps 
      FROM step_users 
      WHERE DATE(tanggal) = '$tanggal';
    '''
    );
    return step;
  }

  fetchLatihanHarianGroup(tanggal) async {
    final database = await SqliteService().database;
    final step = await database.rawQuery(
    '''
      SELECT 
        COUNT(CASE WHEN status = 'belum' THEN 1 END) AS belum_count,
        COUNT(CASE WHEN status = 'sudah' THEN 1 END) AS sudah_count
      FROM workout_users 
      WHERE DATE(tanggal) = '$tanggal';
    '''
    );
    print(step);
    return step;
  }

  

  fetchLatihanHarian(date) async {
    final database = await SqliteService().database;
    final latihan = await database.rawQuery(
      '''
      SELECT *, workout_users.id as workout_user_id
      FROM workout_users
      INNER JOIN workouts ON workouts.id = workout_users.workout_id
      WHERE user_id = 1
      AND tanggal = '$date'
      ''',
    );
    return latihan;
  }

  fetchLatihanAll() async {
    final database = await SqliteService().database;
    final latihan = await database.rawQuery(
      '''
      SELECT *
      FROM workouts
      ''',
    );
    return latihan;
  }

  fetchKaloriHarian(date) async {
    final database = await SqliteService().database;
    final kalori_harian = await database.rawQuery(
      '''
      SELECT u.id AS user_id,
            u.username,
            u.tinggi,
            u.berat,
            u.umur,
            u.jeniskelamin,
            u.type_berat,
            u.target_berat,
            u.aktivitas,
            COALESCE(SUM(k.kalori), 0) AS total_kalori_consumed
      FROM users u
      LEFT JOIN kalori_users k ON u.id = k.user_id
      WHERE u.id = 1
      AND k.tanggal = '$date'
      ''',
    );
    return kalori_harian;
  }

  fetchKaloriHarianGroup(date) async {
    final database = await SqliteService().database;
    final kalori_harian = await database.rawQuery(
      '''
      SELECT u.id AS user_id,
            u.username,
            u.tinggi,
            u.berat,
            u.umur,
            u.jeniskelamin,
            u.type_berat,
            u.target_berat,
            u.aktivitas,
            COALESCE(SUM(CASE WHEN k.minat = 'Breakfast' THEN k.kalori ELSE 0 END), 0) AS breakfast,
            COALESCE(SUM(CASE WHEN k.minat = 'Lunch' THEN k.kalori ELSE 0 END), 0) AS lunch,
            COALESCE(SUM(CASE WHEN k.minat = 'Dinner' THEN k.kalori ELSE 0 END), 0) AS dinner
      FROM users u
      LEFT JOIN kalori_users k ON u.id = k.user_id
      WHERE u.id = 1
      AND k.tanggal = '$date'
      ''',
    );
    return kalori_harian;
  }

  fetchBeratBadan() async {
    final database = await SqliteService().database;
    final berat = await database.rawQuery(
      '''
      SELECT *
      FROM berat_users 
      WHERE user_id = 1
      ''',
    );
    return berat;
  }

  login(username, password) async {
    final database = await SqliteService().database;
    final user = await database.rawQuery(
      '''SELECT * FROM users WHERE username = '$username' AND password = '$password' ''',
    );
    final login = await database.rawQuery(
      '''SELECT * FROM users''',
    );
    if (user.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  fetchUserById(int id) async {
    final database = await SqliteService().database;
    final user = await database.rawQuery(
      '''SELECT * FROM users WHERE id = $id''',
    );
    
    if (user.isNotEmpty) {
      return User.fromMap(user.first);
    } else {
      return null;
    }
  }


  fetchUserByIdV2(int id) async {
    final database = await SqliteService().database;
    final user = await database.rawQuery(
      '''SELECT * FROM users WHERE id = $id''',
    );
    
    return user;
  }

  fetchUserAll() async {
    final database = await SqliteService().database;
    final user = await database.rawQuery(
      '''SELECT * FROM users''',
    );
    return user;
  }

  fetchMeals() async {
    final database = await SqliteService().database;
    final meal = await database.rawQuery(
      '''SELECT * FROM meals''',
    );
    return meal;
  }

  fetchStep() async {
    final database = await SqliteService().database;
    final step = await database.rawQuery(
      '''SELECT * FROM step_users WHERE user_id = 1 ORDER BY id DESC''',
    );
    return step;
  }

  fetchMealDaily(type, date) async {
    final database = await SqliteService().database;
    final kalori_harian = await database.rawQuery(
      '''
      SELECT kalori_users.* , meals.*, kalori_users.id AS kalori_user_id 
      FROM kalori_users 
      LEFT JOIN meals ON kalori_users.meal_id = meals.id
      WHERE minat = '$type'
      AND kalori_users.tanggal = '$date'
      ''',
    );
    return kalori_harian;
  }

  fetchMealById(int id) async {
    final database = await SqliteService().database;
    final meal = await database.rawQuery(
      '''SELECT * FROM meals WHERE id = $id''',
    );
    return meal;
  }

  fetchLatihanById(int id) async {
    final database = await SqliteService().database;
    final latihan = await database.rawQuery(
      '''SELECT * FROM workouts WHERE id = $id''',
    );
    return latihan;
  }

  fetchKaloriHarianJurnal(date) async {
    final database = await SqliteService().database;
    final kalori_harian = await database.rawQuery(
      '''
      SELECT *
      FROM kalori_users
      WHERE tanggal = '$date'
      ''',
    );
    return kalori_harian;
  }

  deleteMealJurnal(id) async {
    final database = await SqliteService().database;
    final kalori_harian = await database.rawDelete(
      '''
      DELETE FROM kalori_users
      WHERE id = ?
      ''',
      ['$id'],
    );
    return kalori_harian;
  }

  deleteBeratBadan(id) async {
    final database = await SqliteService().database;
    final berat_users = await database.rawDelete(
      '''
      DELETE FROM berat_users
      WHERE id = ?
      ''',
      ['$id'],
    );
    return berat_users;
  }

  deleteLatihanHarian(id) async {
    final database = await SqliteService().database;
    final workout_users = await database.rawDelete(
      '''
      DELETE FROM workout_users
      WHERE id = ?
      ''',
      ['$id'],
    );
    return workout_users;
  }
}