import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/widget/circle_slider.dart';
import 'package:watchme/widget/box_slider.dart';
import 'package:watchme/widget/ott_check.dart';
import 'package:http/http.dart' as http;  // http 패키지 임포트
import 'package:watchme/model/model_ott.dart'; // OTT 모델 임포트
import 'dart:convert';  // json 관련 처리를 위한 임포트
import 'package:http/http.dart' as http;
import 'package:watchme/widget/ranking_slider.dart';
import '../widget/list_slider.dart';

Future<List<Movie>> get_ranking_movies_list_from_backend({
  required bool netflixSelected,
  required bool tvingSelected,
  required bool coupangSelected,
  required bool watchaSelected,
  required bool wavveSelected,
  required bool disneySelected,
}) async {
  try {
    final Map<String, dynamic> body = {
      'netflix_selected': netflixSelected,
      'tving_selected': tvingSelected,
      'coupang_selected': coupangSelected,
      'watcha_selected': watchaSelected,
      'wavve_selected': wavveSelected,
      'disney_selected': disneySelected,
    };

    final Uri apiUrl = Uri.parse('http://3.25.85.3:8000/main_page_integrated/'); // 기본 URL

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json', // JSON 형식으로 보내기
      },
      body: json.encode(body), // 데이터를 JSON 형식으로 직렬화
    );

    // print('POST 요청 URL: ${apiUrl.toString()}');
    // print('보낸 데이터: ${json.encode(body)}');

    final decodedBody = utf8.decode(response.bodyBytes);
    // print('응답 본문 (디코딩 후): $decodedBody');
    // print('응답 헤더: ${response.headers}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(decodedBody);
      final List<dynamic> moviesList = jsonData['movies'];

      // print('영화 리스트: $moviesList');
      User user = await UserApi.instance.me();
      // print('사용자ID: ${user.id}');
      // JSON 데이터를 Movie 객체로 변환
      moviesList.map((data) => Movie.fromJson(data['title'], data)).toList().forEach((movie) {
        // print('movie 객체 출력결과');
        // print(netflixSelected);
        // print(watchaSelected);
        // print(coupangSelected);
        // print(watchaSelected);
        // print(wavveSelected);
        // print(disneySelected);
        // print(movie);  // Movie 객체를 출력

      });
      return moviesList.map((data) => Movie.fromJson(data['title'], data)).toList();
    } else {
      throw Exception('영화 데이터를 가져오는 데 실패했습니다: ${response.statusCode}');
    }
  } catch (e) {
    // print('HTTP 요청 중 오류 발생: $e');
    throw Exception('HTTP 요청 중 오류 발생');
  }
}

Future<List<Movie>> get_recommended_movies_list_from_backend({
  required String user_id,
  required bool netflixSelected,
  required bool tvingSelected,
  required bool coupangSelected,
  required bool watchaSelected,
  required bool wavveSelected,
  required bool disneySelected,
}) async {
  try {
    final Map<String, dynamic> body = {
      'user_id': user_id,
      'netflix_selected': netflixSelected,
      'tving_selected': tvingSelected,
      'coupang_selected': coupangSelected,
      'watcha_selected': watchaSelected,
      'wavve_selected': wavveSelected,
      'disney_selected': disneySelected,
    };

    final Uri apiUrl = Uri.parse('http://3.25.85.3:8000/main_page_personal_recommendation/'); // 기본 URL

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json', // JSON 형식으로 보내기
      },
      body: json.encode(body), // 데이터를 JSON 형식으로 직렬화
    );

    // print('POST 요청 URL: ${apiUrl.toString()}');
    // print('보낸 데이터: ${json.encode(body)}');

    final decodedBody = utf8.decode(response.bodyBytes);
    // print('응답 본문 (디코딩 후): $decodedBody');
    // print('응답 헤더: ${response.headers}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(decodedBody);
      final List<dynamic> moviesList = jsonData['movies'];

      // print('영화 리스트: $moviesList');
      User user = await UserApi.instance.me();
      // print('사용자ID: ${user.id}');
      // JSON 데이터를 Movie 객체로 변환
      moviesList.map((data) => Movie.fromJson(data['title'], data)).toList().forEach((movie) {
        // print('movie 객체 출력결과');
        // print(netflixSelected);
        // print(watchaSelected);
        // print(coupangSelected);
        // print(watchaSelected);
        // print(wavveSelected);
        // print(disneySelected);
        // print(movie);  // Movie 객체를 출력

      });
      return moviesList.map((data) => Movie.fromJson(data['title'], data)).toList();
    } else {
      throw Exception('영화 데이터를 가져오는 데 실패했습니다: ${response.statusCode}');
    }
  } catch (e) {
    // print('HTTP 요청 중 오류 발생: $e');
    throw Exception('HTTP 요청 중 오류 발생');
  }
}

Future<List<Movie>> get_movies_list_from_backend({
  required String genre,
  required bool netflixSelected,
  required bool tvingSelected,
  required bool coupangSelected,
  required bool watchaSelected,
  required bool wavveSelected,
  required bool disneySelected,
}) async {
  try {
    final Map<String, dynamic> body = {
      'genre': genre,
      'netflix_selected': netflixSelected,
      'tving_selected': tvingSelected,
      'coupang_selected': coupangSelected,
      'watcha_selected': watchaSelected,
      'wavve_selected': wavveSelected,
      'disney_selected': disneySelected,
    };

    final Uri apiUrl = Uri.parse('http://3.25.85.3:8000/main_page_genre/'); // 기본 URL

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json', // JSON 형식으로 보내기
      },
      body: json.encode(body), // 데이터를 JSON 형식으로 직렬화
    );

    // print('POST 요청 URL: ${apiUrl.toString()}');
    // print('보낸 데이터: ${json.encode(body)}');
    //
    final decodedBody = utf8.decode(response.bodyBytes);
    // print('응답 본문 (디코딩 후): $decodedBody');
    // print('응답 헤더: ${response.headers}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(decodedBody);
      final List<dynamic> moviesList = jsonData['movies'];

      // print('영화 리스트: $moviesList');
      User user = await UserApi.instance.me();
      // print('사용자ID: ${user.id}');
      // JSON 데이터를 Movie 객체로 변환
      moviesList.map((data) => Movie.fromJson(data['title'], data)).toList().forEach((movie) {
        // print('movie 객체 출력결과');
        // print(netflixSelected);
        // print(watchaSelected);
        // print(coupangSelected);
        // print(watchaSelected);
        // print(wavveSelected);
        // print(disneySelected);
        // print(movie);  // Movie 객체를 출력

      });
      return moviesList.map((data) => Movie.fromJson(data['title'], data)).toList();
    } else {
      throw Exception('영화 데이터를 가져오는 데 실패했습니다: ${response.statusCode}');
    }
  } catch (e) {
    // print('HTTP 요청 중 오류 발생: $e');
    throw Exception('HTTP 요청 중 오류 발생');
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool netflix_selected = true;
  bool tving_selected = true;
  bool coupang_selected = true;
  bool watcha_selected = true;
  bool wavve_selected = true;
  bool disney_selected = true;

  String hororGenre = '공포';
  String actionGenre = '액션';
  String romanceGenre = '로맨스';
  String fantasyGenre = '판타지';
  String comedyGenre = '코미디';

  String userId = '';

  // 각기 다른 장르에 대해 각각의 영화 데이터를 저장할 변수

  List<Movie> rankingMovies = [];
  List<Movie> recommendedMovies = [];
  List<Movie> hororMovies = [];
  List<Movie> actionMovies = [];
  List<Movie> romanceMovies = [];
  List<Movie> fantasyMovies = [];
  List<Movie> comedyMovies = [];


  bool isLoading = true;

  Future<void> updateMoviesData() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<Movie> fetchedHororMovies = await get_movies_list_from_backend(
        genre: hororGenre,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
        disneySelected: disney_selected,
      );

      List<Movie> fetchedActionMovies = await get_movies_list_from_backend(
        genre: actionGenre,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
        disneySelected: disney_selected,
      );

      List<Movie> fetchedRomanceMovies = await get_movies_list_from_backend(
        genre: romanceGenre,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
        disneySelected: disney_selected,
      );

      List<Movie> fetchedFantasyMovies = await get_movies_list_from_backend(
        genre: fantasyGenre,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
        disneySelected: disney_selected,
      );

      List<Movie> fetchedComedyMovies = await get_movies_list_from_backend(
        genre: comedyGenre,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
        disneySelected: disney_selected,
      );


      User user = await UserApi.instance.me();
      // print('사용자ID: ${user.id}');
      List<Movie> fetchedRecommendedMovies = await get_recommended_movies_list_from_backend(
        user_id: "${user.id}",
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
        disneySelected: disney_selected,
      );

      List<Movie> fetchedRankingMovies = await get_ranking_movies_list_from_backend(
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
        disneySelected: disney_selected,
      );

      setState(() {
        hororMovies = fetchedHororMovies;
        actionMovies = fetchedActionMovies;
        romanceMovies = fetchedRomanceMovies;
        fantasyMovies = fetchedFantasyMovies;
        comedyMovies = fetchedComedyMovies;
        recommendedMovies = fetchedRecommendedMovies;
        rankingMovies = fetchedRankingMovies;
        isLoading = false;
      });
    } catch (e) {
      // print("데이터 업데이트 중 오류 발생: $e");
      setState(() {
        isLoading = false;
      });
    }
  }




  @override
  void initState() {
    super.initState();
    updateMoviesData().then((_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color> (Colors.white),)) // 로딩 중 상태
        : Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          OTTbar(
            netflixSelected: netflix_selected,
            tvingSelected: tving_selected,
            coupangSelected: coupang_selected,
            watchaSelected: watcha_selected,
            wavveSelected: wavve_selected,
            disneySelected: disney_selected,
            onSelectionChanged: ({
              required bool netflix,
              required bool tving,
              required bool coupang,
              required bool watcha,
              required bool wavve,
              required bool disney,
            }) {
              setState(() {
                netflix_selected = netflix;
                tving_selected = tving;
                coupang_selected = coupang;
                watcha_selected = watcha;
                wavve_selected = wavve;
                disney_selected = disney;
              });
              updateMoviesData();
            },
          ),
          RankingSliderVertical(movies: rankingMovies, sliderTitle: '통합 순위!'),
          CircleSlider (movies: recommendedMovies, sliderTitle: '당신만을 위한 추천!'),
          BoxSlider(movies: hororMovies, sliderTitle: hororGenre),
          BoxSlider(movies: romanceMovies, sliderTitle: romanceGenre),
          BoxSlider(movies: actionMovies, sliderTitle: actionGenre),
          BoxSlider(movies: fantasyMovies, sliderTitle: fantasyGenre),
          BoxSlider(movies: comedyMovies, sliderTitle: comedyGenre),
        ],
      ),
    );
  }
}
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/icpcteam.png', // 예시 아이콘
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV program',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'Drama',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'Music',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}