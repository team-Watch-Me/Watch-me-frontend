// list_slider.dart

import 'package:flutter/material.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/screen/detail_screen.dart';  // 영화 상세 화면

class ListSlider extends StatelessWidget {
  final List<Movie> movies;

  // 생성자
  ListSlider({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        // 화면 꽉 차게 하도록 조정
        height: MediaQuery.of(context).size.height * 0.6, // 화면의 60% 크기
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<Null>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return DetailScreen(movie: movies[index]);
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // 제목과 장르를 상단에 맞춤
                  children: [
                    // 영화 포스터 이미지 - 더 작게 조정
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Image.network(
                          movies[index].poster_url, // 수정된 부분: poster_url 사용
                          height: 180, // 영화 포스터 높이
                          width: 120, // 영화 포스터 너비
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    // 영화 제목과 장르
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // 제목 색상 흰색으로 설정
                            ),
                            overflow: TextOverflow.ellipsis, // 제목이 길면 생략
                          ),
                          SizedBox(height: 5),
                          Text(
                            movies[index].genre,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey, // 장르는 여전히 회색으로 설정
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
