import 'package:sqlite_getx/data/database/reviews_database.dart';
import 'package:sqlite_getx/data/models/review.dart';

abstract class LocalDataSource {
  Future<List<Results>>? getAllReviews();
  Future<void>? insertReviews(Results review);
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<Results>>? getAllReviews() async {
    return await ReviewsDatabase.instance.readAllReviews();
  }

  @override
  Future<void>? insertReviews(Results review) async {
    return await ReviewsDatabase.instance.insertReview(review);
  }
}
