import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sqlite_getx/core/error/exceptions.dart';
import 'package:sqlite_getx/core/error/failures.dart';
import 'package:sqlite_getx/core/network_info/network_info.dart';
import 'package:sqlite_getx/data/datasources/local_datasource.dart';
import 'package:sqlite_getx/data/datasources/remote_datasource.dart';
import 'package:sqlite_getx/data/models/review.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Results>>>? getAllReviews();
}

const String _noInternet = 'No Internet Connection';

class HomeRepositoryImpl implements HomeRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Results>>>? getAllReviews() async {
    // ReviewsDatabase.instance.deleteReview(1);
    // ReviewsDatabase.instance.deleteReview(2);

    if (await networkInfo.isConnected) {
      try {
        final remoteReviews = await remoteDataSource.getAllReviews();
        for (var element in remoteReviews!.results!) {
          await localDataSource.insertReviews(element);
        }
        final reviews = await localDataSource.getAllReviews();
        
        return Right(reviews!);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(e.message),
        );
      }
    } else {
      try {
        final reviews = await localDataSource.getAllReviews();
        return Right(reviews!);
      } on CacheException catch (e) {
        return left(
          ChacheFailure(
            e.message,
          ),
        );
      }
    }
  }
}
