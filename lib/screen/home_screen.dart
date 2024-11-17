import 'package:flutter/material.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/widget/carousel_slider.dart';
import 'package:watchme/widget/circle_slider.dart';
import 'package:watchme/widget/box_slider.dart';
import 'package:watchme/widget/ott_check.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': ['사랑', '로맨스', '판타지'], // keyword는 리스트 형태로 수정
      'poster': 'https://example.com/images/intern.jpeg', // 웹 이미지 URL로 수정
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': ['사랑', '로맨스', '판타지'],
      'poster': 'https://example.com/images/intern.jpeg',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': ['사랑', '로맨스', '판타지'],
      'poster': 'https://example.com/images/intern.jpeg',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': ['사랑', '로맨스', '판타지'],
      'poster': 'https://example.com/images/intern.jpeg',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': ['사랑', '로맨스', '판타지'],
      'poster': 'https://example.com/images/intern.jpeg',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': ['사랑', '로맨스', '판타지'],
      'poster': 'https://example.com/images/icpcteam.png', // 웹 이미지 URL로 수정
      'like': false
    }),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // 원하는 패딩 값
      child: ListView(
        children: <Widget>[
          TopBar(),
          OTTbar(),
          CarouselImage(movies: movies),
          CircleSlider(movies: movies),
          BoxSlider(movies: movies),
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