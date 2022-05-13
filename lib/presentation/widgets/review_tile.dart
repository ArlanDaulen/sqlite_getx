import 'package:flutter/material.dart';
import 'package:sqlite_getx/data/models/review.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({Key? key, required this.review}) : super(key: key);
  final Results review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Author: ' + review.author!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          review.content!,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
