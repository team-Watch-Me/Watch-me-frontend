import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:watchme/screen/detail_screen.dart';
import 'package:watchme/model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;

  CarouselImage({required this.movies});

  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie> movies = [];
  List<Widget> images = [];
  List<List<String>> keywords = [];
  List<bool> likes = [];
  int _currentPage = 0;
  String _currentKeyword = "";

  @override
  void initState() {
    super.initState();
    movies = widget.movies;

    // 이미지 경로가 웹 링크로 제공되므로 Image.network를 사용
    images = movies.map((m) => Image.network(m.poster)).toList();

    // 키워드와 좋아요 상태를 목록으로 추출
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();

    // 초기 키워드 설정
    _currentKeyword = keywords.isNotEmpty && keywords[0].isNotEmpty
        ? keywords[0][0]  // 첫 번째 키워드의 첫 번째 항목
        : '';  // 비어있으면 빈 문자열
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
        ),
        CarouselSlider(
          items: images,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage][0]; // 현재 페이지의 첫 번째 키워드
              });
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
          child: Text(
            _currentKeyword,
            style: TextStyle(fontSize: 11),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    likes[_currentPage]
                        ? IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {},
                    )
                        : IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {},
                    ),
                    Text(
                      '찜한 콘텐츠',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                      ),
                      Text('Play', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return DetailScreen(
                                movie: movies[_currentPage],
                              );
                            }
                        ));
                      },
                    ),
                    Text(
                      '정보',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // runningTime을 int로 출력하는 부분 수정
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            '상영 시간: ${movies[_currentPage].runningTime.toString()} 분',  // runningTime을 출력
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: makeIndicator(likes, _currentPage),
          ),
        ),
      ],
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == i
            ? Color.fromRGBO(255, 255, 255, 0.9)
            : Color.fromRGBO(255, 255, 255, 0.4),
      ),
    ));
  }
  return results;
}