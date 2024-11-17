import 'package:flutter/material.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/widget/carousel_slider.dart';
import 'package:watchme/widget/circle_slider.dart';
import 'package:watchme/widget/box_slider.dart';
import 'package:watchme/widget/ott_check.dart';
import 'package:http/http.dart' as http;  // http 패키지 임포트
import 'package:flutter/material.dart';
import 'package:watchme/model/model_ott.dart'; // OTT 모델 임포트
import 'package:watchme/widget/ott_check.dart'; // OTTbar 임포트

import 'dart:convert';  // json 관련 처리를 위한 임포트

// 일반적인 영화 데이터를 가져오는 함수 (장르와 OTT 선택 여부를 받음)
import 'package:http/http.dart' as http;
Future<List<Movie>> get_movies_list_from_backend({
  required String genre,
  required bool netflixSelected,
  required bool tvingSelected,
  required bool coupangSelected,
  required bool watchaSelected,
  required bool wavveSelected,
}) async {
  try {
    final Map<String, dynamic> body = {
      'genre': genre,
      'netflix_selected': netflixSelected,
      'tving_selected': tvingSelected,
      'coupang_selected': coupangSelected,
      'watcha_selected': watchaSelected,
      'wavve_selected': wavveSelected,
    };

    final Uri apiUrl = Uri.parse('http://3.25.175.71:8000/main_page/'); // 기본 URL

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json', // JSON 형식으로 보내기
      },
      body: json.encode(body), // 데이터를 JSON 형식으로 직렬화
    );

    print('POST 요청 URL: ${apiUrl.toString()}');  // 요청 URL 출력
    print('보낸 데이터: ${json.encode(body)}'); // 보낸 데이터 출력

    // 응답 본문 출력
    print('응답 본문: ${response.body}');  // 받은 응답을 출력합니다.

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> moviesList = jsonData['movies'];

      print('영화 리스트: $moviesList');

      // JSON 데이터를 Movie 객체로 변환
      moviesList.map((data) => Movie.fromJson(data['title'], data)).toList().forEach((movie) {
        print('movie 객체 출력결과');
        print(netflixSelected);
        print(watchaSelected);
        print(coupangSelected);
        print(watchaSelected);
        print(wavveSelected);
        print(movie);  // Movie 객체를 출력

      });
      return moviesList.map((data) => Movie.fromJson(data['title'], data)).toList();
    } else {
      throw Exception('영화 데이터를 가져오는 데 실패했습니다: ${response.statusCode}');
    }
  } catch (e) {
    print('HTTP 요청 중 오류 발생: $e');
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
  bool coupang_selected = false;
  bool watcha_selected = true;
  bool wavve_selected = true;

  String selectedGenreForCarousel = '공포';  // Carousel에 사용할 장르
  String selectedGenreForCircle = '액션';   // CircleSlider에 사용할 장르
  String selectedGenreForBox = '로맨스';    // BoxSlider에 사용할 장르

  // 각기 다른 장르에 대해 각각의 영화 데이터를 저장할 변수
  List<Movie> carouselMovies = [];
  List<Movie> circleMovies = [];
  List<Movie> boxMovies = [];




  /*
  // Carousel 데이터를 가져오는 함수
  Future<void> getCarouselMoviesData() async {
    try {
      List<Movie> fetchedMovies = await get_movies_list_from_backend(
        genre: selectedGenreForCarousel,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
      );
      setState(() {
        carouselMovies = fetchedMovies;
      });
    } catch (e) {
      print("Carousel 데 이터를 가져오는 데 실패했습니다: $e");
    }
  }

  // CircleSlider 데이터를 가져오는 함수
  Future<void> getCircleMoviesData() async {
    try {
      List<Movie> fetchedMovies = await get_movies_list_from_backend(
        genre: selectedGenreForCircle,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
      );
      setState(() {
        circleMovies = fetchedMovies;
      });
    } catch (e) {
      print("CircleSlider 데이터를 가져오는 데 실패했습니다: $e");
    }
  }

  // BoxSlider 데이터를 가져오는 함수
  Future<void> getBoxMoviesData() async {
    try {
      List<Movie> fetchedMovies = await get_movies_list_from_backend(
        genre: selectedGenreForBox,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
      );
      setState(() {
        boxMovies = fetchedMovies;
      });
    } catch (e) {
      print("BoxSlider 데이터를 가져오는 데 실패했습니다: $e");
    }
  }
*/

  // 공통 함수
  Future<void> getMoviesData({
    required String genre, // 장르
    required List<Movie> targetList, // 업데이트할 리스트
  }) async {
    try {
      List<Movie> fetchedMovies = await get_movies_list_from_backend(
        genre: genre,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
      );
      setState(() {
        targetList.clear(); // 기존 데이터를 제거
        targetList.addAll(fetchedMovies); // 새로운 데이터 추가
      });
    } catch (e) {
      print("$genre 데이터를 가져오는 데 실패했습니다: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getMoviesData(
      genre: selectedGenreForCarousel,
      targetList: carouselMovies,
    );
    getMoviesData(
      genre: selectedGenreForCircle,
      targetList: circleMovies,
    );
    getMoviesData(
      genre: selectedGenreForBox,
      targetList: boxMovies,
    );
    //getCarouselMoviesData();
    //getCircleMoviesData();
    //getBoxMoviesData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          TopBar(),
          OTTbar(
            // OTTbar에 상태값과 콜백 함수 전달
            netflixSelected: netflix_selected,
            tvingSelected: tving_selected,
            coupangSelected: coupang_selected,
            watchaSelected: watcha_selected,
            wavveSelected: wavve_selected,
            onSelectionChanged: ({
              required bool netflix,
              required bool tving,
              required bool coupang,
              required bool watcha,
              required bool wavve,
            }) {
              setState(() {
                netflix_selected = netflix;
                tving_selected = tving;
                coupang_selected = coupang;
                watcha_selected = watcha;
                wavve_selected = wavve;
              });
              //getCarouselMoviesData(); // 상태가 바뀌면 다시 쿼리 보내기
              /*getMoviesData(
                genre: selectedGenreForCarousel,
                targetList: carouselMovies,
              );
              */
              getMoviesData(
                genre: selectedGenreForCircle,
                targetList: circleMovies,
              );
              getMoviesData(
                genre: selectedGenreForBox,
                targetList: boxMovies,
              );
            },
          ),
          // 각 위젯에 전달되는 데이터는 각기 다른 장르에 대한 영화 데이터입니다.
          //CarouselImage(movies: carouselMovies),
          CircleSlider(movies: circleMovies),
          BoxSlider(movies: boxMovies),
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