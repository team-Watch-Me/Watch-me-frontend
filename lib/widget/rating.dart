import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // 별점 바 패키지

class RatingWidget extends StatelessWidget {
  final double initialRating;
  final Function(double) onRatingUpdate;

  const RatingWidget({
    Key? key,
    required this.initialRating,
    required this.onRatingUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 40.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
Future<void> showRatingDialog(
    BuildContext context,
    void Function(double rating) onRatingComplete, // 수정: 별점만 받는 콜백
    ) {
  double _rating = 0;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 별점 위젯
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              onRatingUpdate: (rating) {
                _rating = rating;
              },
            ),
            // 코멘트 입력 필드 (옵션)
            TextField(
              decoration: InputDecoration(hintText: '코멘트를 남겨주세요 (선택)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 별점이 설정되면 onRatingComplete 호출
              onRatingComplete(_rating);
              Navigator.of(context).pop();
            },
            child: Text(
              '제출',
              style: TextStyle(
                color: Colors.white, // 흰색으로 설정
              ),
            ),
          ),
        ],
      );
    },
  );
}

