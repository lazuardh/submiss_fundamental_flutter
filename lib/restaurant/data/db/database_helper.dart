// import 'package:sqflite/sqflite.dart';
// import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';

// class DatabaseHelper {
//   static DatabaseHelper? _instance;
//   static Database? _database;

//   DatabaseHelper._internal() {
//     _instance = this;
//   }

//   factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

//   static const String _tbFavorit = 'favorite';

//   Future<Database> _initializeDb() async {
//     var path = await getDatabasesPath();
//     var db = openDatabase(
//       '$path/restaurant.db',
//       onCreate: (db, version) async {
//         await db.execute('''CREATE TABLE $_tbFavorit (
//               id TEXT PRIMARY KEY,
//               name TEXT,
//               description TEXT,
//               picturedId TEXT,
//               city TEXT,
//               rating int,
//             )
//           ''');
//       },
//       version: 1,
//     );
//     return db;
//   }

//   Future<Database?> get database async {
//     if (_database == null) {
//       _database = await _initializeDb();
//     }

//     return _database;
//   }

//   Future<void> insertFavorite(Restaurant restaurant) async {
//     final db = await database;
//     await db!.insert(_tbFavorit, restaurant.toJson());
//   }

//   Future<List<Restaurant>> getFavoriteRestaurant() async {
//     final db = await database;
//     List<Map<String, dynamic>> results = await db!.query(
//       _tbFavorit,
//       where: 'id = ?',
//       whereArgs: [id],
//     );

//     if (results.isNotEmpty) {
//       return results.first;
//     } else {
//       return {};
//     }
//   }
// }
