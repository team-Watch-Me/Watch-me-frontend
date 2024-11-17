class Movie {
  final String title;
  final List<String> contentName;
  final List<String> streamingProvider;
  final String plot;
  final String genre;
  final String ageRating;
  final String country;
  final String releaseDate;
  final int runningTime;  // int로 변경
  final String year;
  final String poster;
  bool like; // 좋아요 상태
  final List<String> keyword; // 키워드 리스트

  Movie({
    required this.title,
    required this.contentName,
    required this.streamingProvider,
    required this.plot,
    required this.genre,
    required this.ageRating,
    required this.country,
    required this.releaseDate,
    required this.runningTime,  // int로 전달
    required this.year,
    required this.poster,
    required this.keyword, // 키워드 리스트
    this.like = false, // 기본값 false
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
        contentName: json['content_name'] ?? ['더미 콘텐츠'],  // 더미 데이터 설정
        streamingProvider: json['streaming_provider'] ?? ['더미 스트리밍 서비스'],  // 더미 데이터 설정
        plot: json['description'] ?? '설명 없음',  // 기본값 설정
        genre: json['genre'] ?? '장르 정보 없음',  // 기본값 설정
        ageRating: json['age_rating'] ?? '연령 정보 없음',  // 기본값 설정
        country: json['country'] ?? '국가 정보 없음',  // 기본값 설정
        releaseDate: json['release_date'] ?? '발매일 정보 없음',  // 기본값 설정
        runningTime: (json['running_time'] is int) ? json['running_time'] : 120,  // 기본값 설정 (더미 값: 120)
        year: json['release_date'] != null && json['release_date'].contains('-')
            ? json['release_date'].split('-')[0]
            : '발매일 없음',  // 기본값 설정
        poster: 'https://dummyimage.com/200x300/000/fff',  // 더미 이미지 URL 설정
        keyword: ['더미 키워드'],  // 더미 데이터 설정
        like: json['like'] ?? true,  // 기본값 설정 (더미 값: true)
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
      contentName: [], // 백엔드 데이터에 없으므로 빈 리스트로 처리
      streamingProvider: [], // 백엔드 데이터에 없으므로 빈 리스트로 처리
      plot: map['description'] ?? '', // 백엔드의 `description` 필드로 매핑
      genre: map['genre'] ?? '',
      ageRating: map['age_rating'] ?? '',
      country: map['country'] ?? '',
      releaseDate: map['release_date'] ?? '',
      runningTime: map['running_time'] ?? 0,
      year: map['release_date'] != null
          ? map['release_date'].split('-')[0] // release_date에서 연도 추출
          : '',
      poster: '', // 포스터 URL이 없으므로 빈 문자열로 처리
      keyword: [], // 백엔드 데이터에 없으므로 빈 리스트로 처리
      like: false, // 좋아요 초기값
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, keyword: $keyword, poster: $poster, like: $like, description: $plot, genre: $genre, releaseDate: $releaseDate, runningTime: $runningTime)';
  }


}