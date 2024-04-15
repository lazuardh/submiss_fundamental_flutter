import 'package:sqflite/sqflite.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tbFavorit = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restauran.db',
      onCreate: (db, version) async {
        try {
          await db.execute('''CREATE TABLE $_tbFavorit (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXT,
              rating REAL
           )
        ''');
          print('Table $_tbFavorit created successfully');
        } catch (e) {
          print('Error creating table: $e');
        }
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertFavorite(RestaurantElement restaurant) async {
    final db = await database;

    print('Inserting restaurant with ID: ${restaurant.id} into bookmarks...');

    await db!.insert(_tbFavorit, restaurant.toJson());

    // await db!.insert(_tbFavorit, {
    //   'id': restaurant.id,
    //   'name': restaurant.name,
    //   'description': restaurant.description,
    //   'city': restaurant.city,
    //   'pictureId': restaurant.pictureId,
    //   'rating': restaurant.rating,
    // });
  }

  Future<List<RestaurantElement>> getFavoriteRestaurant() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tbFavorit);

    return results
        .map((response) => RestaurantElement.fromJson(response))
        .toList();
  }

  Future<Map> getFavoriteRestaurantById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tbFavorit,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavoriteRestaurant(String id) async {
    final db = await database;

    await db!.delete(
      _tbFavorit,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
