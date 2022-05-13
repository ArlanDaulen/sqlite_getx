import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqlite_getx/core/network_info/network_info.dart';
import 'package:sqlite_getx/data/datasources/local_datasource.dart';
import 'package:sqlite_getx/data/datasources/remote_datasource.dart';
import 'package:sqlite_getx/data/models/review.dart';
import 'package:sqlite_getx/data/repositories/home_repository.dart';

class HomeController extends GetxController {
  HomeRepository repository = HomeRepositoryImpl(
    remoteDataSource: RemoteDataSourceImpl(),
    localDataSource: LocalDataSourceImpl(),
    networkInfo: NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  @override
  void onInit() {
    fetchReviews();
    // _addReviewController.stream.listen(
    //   _handleAddReview,
    //   onDone: () => log('hvgcfxdfcgvhbjn'),
    // );
    super.onInit();
  }

  @override
  void dispose() {
    // _reviewsController.close();
    // _addReviewController.close();
    streamController.close();
    super.dispose();
  }

  var isLoading = false.obs;
  var error = ''.obs;
  var reviewList = <Results>[].obs;
  var isReversed = false.obs;
  final StreamController<bool> streamController = StreamController<bool>();
  bool isReversedStream = false;

  TextEditingController contentController = TextEditingController();

  void fetchReviews() async {
    isLoading(true);
    var failureOrReviews = await repository.getAllReviews();
    failureOrReviews!.fold(
      (failure) {
        isLoading(false);
        error(failure.message);
      },
      (_reviews) {
        // _reviewsController.sink.add(_reviews);
        reviewList.value = _reviews;
        isLoading(false);
      },
    );
  }

  void setReverse() {
    isReversed(!isReversed.value);
  }

  void setReverseStream() {
    isReversedStream = !isReversedStream;
    streamController.sink.add(!isReversedStream);
  }

}
