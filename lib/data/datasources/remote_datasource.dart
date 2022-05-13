import 'dart:convert';
import 'dart:developer';

import 'package:sqlite_getx/core/error/exceptions.dart';
import 'package:sqlite_getx/core/error/helper.dart';
import 'package:sqlite_getx/data/models/review.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<Review>? getAllReviews();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  http.Client client = http.Client();
  var headers = {'Content-Type': 'application/json'};

  @override
  Future<Review>? getAllReviews() async {
    var response = await client.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/675353/reviews?api_key=7b79568d4e94ac70052f8e960cc7aa12&language=en-US&page=1',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      return Review.fromJson(json.decode(response.body));
    } else {
      log(response.statusCode.toString());
      throw ServerException(
        message: Helper.errorHandle(
          response.statusCode,
          json.decode(response.body)['status_message'],
        ),
      );
    }
  }
}
