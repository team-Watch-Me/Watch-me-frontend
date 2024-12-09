import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:watchme/model/model_movie.dart';  // Movie import

Future<void> submitRating({
  required String userId,     // 사용자 ID
  required String movieId,    // 영화 ID
  required double rating,     // 평가 점수
}) async {
  try {
    // 평가 전송을 위한 JSON 형식의 데이터 준비
    final Map<String, dynamic> body = {
      'user_id': userId,
      'movie_id': movieId,
      'rating': rating,
      'timestamp': DateTime.now().millisecondsSinceEpoch ~/ 1000,  // 타임스탬프 (현재 시간)
    };

    // 서버의 평가 제출 API URL (예시)
    final Uri apiUrl = Uri.parse('http://3.25.85.3:8000/submit_rating/'); // 평가 전송 URL

    // POST 요청
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json', // JSON 형식으로 보내기
      },
      body: json.encode(body), // 데이터를 JSON 형식으로 직렬화
    );

    print('POST 요청 URL: ${apiUrl.toString()}');
    print('보낸 데이터: ${json.encode(body)}');

    if (response.statusCode == 200) {
      print('평가 전송 성공');
      // 서버 응답 처리 (필요 시)
      final responseData = json.decode(response.body);
      print('서버 응답: $responseData');
    } else {
      print('평가 전송 실패: ${response.statusCode}');
      throw Exception('평가 전송 실패');
    }
  } catch (e) {
    print('HTTP 요청 중 오류 발생: $e');
    throw Exception('평가 전송 중 오류 발생');
  }
}
