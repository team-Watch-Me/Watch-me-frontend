import 'package:tuple/tuple.dart';

class Movie {
  final String title;
  final List<String> genre;
  final String ageRating;
  final List<String> country;
  final String year;
  final int runningTime;  // int로 변경
  final String description;
  final String posterURL;
  final List<String> actor;
  final List<String> staff;
  final List<Tuple2<String, String>> ottProvider;

  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.ageRating,
    required this.country,
    required this.runningTime,  // int로 전달
    required this.year,
    required this.posterURL,
    required this.actor,
    required this.staff,
    required this.ottProvider,
  });



  // JSON 데이터를 Movie 객체로 변환
// JSON 데이터를 Movie 객체로 변환
// JSON 데이터를 Movie 객체로 변환
  factory Movie.fromJson(String title, Map<String, dynamic> json) {
    try {
      // 디버깅용 출력
      print('제목: $title');
      print('description: ${json['description']}');
      print('genre: ${json['genre']}');
      print('age_rating: ${json['age_rating']}');
      print('country: ${json['country']}');
      print('release_date: ${json['release_date']}');
      print('running_time: ${json['running_time']}');
      print('like: ${json['like']}');
      print('ottProvider: ${json['ott_provider']}');

      return Movie(
        title: title.isNotEmpty ? title : '제목 없음',  // 기본값 설정
        description: json['description'] ?? '설명 없음',  // 기본값 설정
        genre: List<String>.from(json['genre'] ?? []), //
        ageRating: json['age_rating'] ?? '연령 정보 없음',  // 기본값 설정
        country: List<String>.from(json['country'] ?? []), // 리스트 변환 추가
        year: json['year'] ?? '발매일 정보 없음',  // 기본값 설정
        runningTime: (json['running_time'] is int) ? json['running_time'] : 120,  // 기본값 설정 (더미 값: 120
        posterURL: json['poster_url'] ?? '포스터 없음',
        ottProvider: (json['ott_provider'] as List<dynamic>?)
            ?.map((item) => Tuple2<String, String>(
            item[0] as String? ?? '', item[1] as String? ?? ''))
            .toList() ??
            [], // Tuple 변환
        actor: List<String>.from(json['actor'] ?? []), //
        staff: List<String>.from(json['staff'] ?? []), //

      );
    } catch (e) {
      print('Movie.fromJson 변환 오류: $e');
      print('문제 데이터: $json');
      rethrow;
    }
  }

  // Map 데이터를 Movie 객체로 변환
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      description: map['description'] ?? '', // 백엔드의 `description` 필드로 매핑
      genre: List<String>.from(map['genre'] ?? []),
      ageRating: map['age_rating'] ?? '',
      country: List<String>.from(map['country'] ?? []), // 리스트 변환 추가
      year: map['year'] ?? '',
      runningTime: map['running_time'] ?? 0,
      posterURL: '', // 포스터 URL이 없으므로 빈 문자열로 처리
      ottProvider: (map['ott_provider'] as List<dynamic>?)
          ?.map((item) => Tuple2<String, String>(
          item[0] as String? ?? '', item[1] as String? ?? ''))
          .toList() ??
          [],
      actor: List<String>.from(map['acort'] ?? []),
      staff: List<String>.from(map['staff'] ?? []),
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, poster_url: $posterURL, description: $description, genre: $genre, year: $year, runningTime: $runningTime)';
  }


}