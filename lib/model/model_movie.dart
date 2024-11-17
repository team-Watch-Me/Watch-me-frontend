class Movie {
  final String title;
  final List<String> contentName;
  final List<String> streamingProvider;
  final String plot;
  final String genre;
  final String ageRating;
  final String country;
  final String releaseDate;
  final String runningTime;
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
    required this.runningTime,
    required this.year,
    required this.poster,
    required this.keyword, // 키워드 리스트
    this.like = false, // 기본값 false
  });

  // JSON 데이터를 Movie 객체로 변환
  factory Movie.fromJson(String title, Map<String, dynamic> json) {
    return Movie(
      title: title,
      contentName: List<String>.from(json['content_name'] ?? []),
      streamingProvider: List<String>.from(json['streaming_provider'] ?? []),
      plot: (json['plot'] ?? [''])[0],
      genre: (json['genre'] ?? [''])[0],
      ageRating: (json['age_rating'] ?? [''])[0],
      country: (json['country'] ?? [''])[0],
      releaseDate: (json['release_date'] ?? [''])[0],
      runningTime: (json['running_time'] ?? [''])[0],
      year: (json['year'] ?? [''])[0],
      poster: json['poster'] ?? '', // 웹 링크로 제공되는 포스터 URL
      keyword: List<String>.from(json['keyword'] ?? []), // 키워드 처리
      like: json['like'] ?? false, // 좋아요 상태 처리
    );
  }

  // Map 데이터를 Movie 객체로 변환
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      contentName: List<String>.from(map['content_name'] ?? []),
      streamingProvider: List<String>.from(map['streaming_provider'] ?? []),
      plot: (map['plot'] ?? [''])[0],
      genre: (map['genre'] ?? [''])[0],
      ageRating: (map['age_rating'] ?? [''])[0],
      country: (map['country'] ?? [''])[0],
      releaseDate: (map['release_date'] ?? [''])[0],
      runningTime: (map['running_time'] ?? [''])[0],
      year: (map['year'] ?? [''])[0],
      poster: map['poster'] ?? '', // 포스터 URL 처리
      keyword: List<String>.from(map['keyword'] ?? []), // 키워드 처리
      like: map['like'] ?? false, // 좋아요 상태 처리
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, keyword: $keyword, poster: $poster, like: $like)';
  }
}