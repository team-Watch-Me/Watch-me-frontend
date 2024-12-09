import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:watchme/widget/movie_details.dart';  // MovieDetails import
import 'package:watchme/widget/rating.dart';  // RatingDialog 관련 함수 import
import 'package:watchme/widget/submit_rating.dart';  // submitRating 함수 import
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
class DetailScreen extends StatefulWidget {
  final Movie movie;

  DetailScreen({required this.movie});

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // 배경 이미지
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.movie.posterURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.4),
                          child: Column(
                            children: <Widget>[
                              // 영화 포스터
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                height: 300,
                                child: CachedNetworkImage(
                                  imageUrl: widget.movie.posterURL,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              // 영화 제목
                              Container(
                                padding: EdgeInsets.all(7),
                                child: Text(
                                  widget.movie.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 5,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // 영화 설명
                              Container(
                                padding: EdgeInsets.all(7),
                                child: Text(
                                  widget.movie.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // AppBar 위치
                  Positioned(
                    child: AppBar(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      elevation: 0,
                      title: Text(
                        widget.movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 영화 세부 정보 부분을 MovieDetails로 대체
              MovieDetails(movie: widget.movie),
              // 버튼 영역 (예시로 좋아요, 평가, 공유 버튼들)
              Container(
                color: Colors.black26,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildActionButton(
                      icon: like ? Icons.check : Icons.add,
                      label: '찜하기',
                      onTap: () {
                        setState(() {
                          like = !like;
                        });
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.thumb_up,
                      label: '평가',
                      onTap: () async{
                        User user = await UserApi.instance.me();
                        print('사용자ID: ${user.id}');
                        // 평가 버튼 클릭 시 showRatingDialog 호출
                        showRatingDialog(
                          context,
                              (rating) {
                            // 평가 완료 후 처리 로직 (예: 서버에 저장)
                            print('Rating: $rating');
                            // 서버에 평가를 보내는 함수 호출
                            submitRating(
                              userId: user.id.toString(), // 예시로 userId를 'user123'로 설정 (실제값으로 변경)
                              movieId: widget.movie.movieId, // movieId는 해당 영화의 ID
                              rating: rating,
                            );
                          },
                        );
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.link,
                      label: '공유',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 버튼을 좀 더 이쁘게 만들어주는 함수
  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white30,
            radius: 25,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
