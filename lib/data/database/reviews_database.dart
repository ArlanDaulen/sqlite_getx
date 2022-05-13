import 'dart:developer';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/review.dart';

class ReviewsDatabase extends GetxController {
  static final ReviewsDatabase instance = ReviewsDatabase._init();
  static Database? _database;

  ReviewsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        'reviews.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE reviews(id TEXT PRIMARY KEY, author TEXT, content TEXT, createdAt TEXT, updatedAt TEXT, url TEXT)',
        );
      },
      version: 1,
    );

    return _database!;
  }

  Future<void> insertReview(Results review) async {
    final db = await database;
    await db.insert(
      'reviews',
      review.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Results>> readAllReviews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reviews');

    return List.generate(
      maps.length,
      (i) => Results(
        id: maps[i]['id'],
        author: maps[i]['author'],
        content: maps[i]['content'],
        createdAt: maps[i]['createdAt'],
        updatedAt: maps[i]['updatedAt'],
        url: maps[i]['url'],
      ),
    );
  }

  Future<void> deleteReview(int id) async {
    final db = await database;
    await db.delete(
      'reviews',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
