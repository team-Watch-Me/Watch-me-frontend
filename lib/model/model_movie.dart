class Movie {
  final String title;
  final String genre;
  final String ageRating;
  final String country;
  final String year;
  final int runningTime;  // int로 변경
  final String description;
  final String poster_url;

  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.ageRating,
    required this.country,
    required this.runningTime,  // int로 전달
    required this.year,
    required this.poster_url,
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

      return Movie(
        title: title.isNotEmpty ? title : '제목 없음',  // 기본값 설정
        description: json['description'] ?? '설명 없음',  // 기본값 설정
        genre: json['genre'] ?? '장르 정보 없음',  // 기본값 설정
        ageRating: json['age_rating'] ?? '연령 정보 없음',  // 기본값 설정
        country: json['country'] ?? '국가 정보 없음',  // 기본값 설정
        year: json['year'] ?? '발매일 정보 없음',  // 기본값 설정
        runningTime: (json['running_time'] is int) ? json['running_time'] : 120,  // 기본값 설정 (더미 값: 120)
        poster_url: json['poster_url'] ?? '포스터 없음'
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
      genre: map['genre'] ?? '',
      ageRating: map['age_rating'] ?? '',
      country: map['country'] ?? '',
      year: map['year'] ?? '',
      runningTime: map['running_time'] ?? 0,
      poster_url: '', // 포스터 URL이 없으므로 빈 문자열로 처리
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, poster_url: $poster_url, description: $description, genre: $genre, year: $year, runningTime: $runningTime)';
  }


}