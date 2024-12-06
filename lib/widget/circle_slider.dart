import 'package:flutter/material.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/screen/detail_screen.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie> movies;
  final String sliderTitle;

  CircleSlider({
    required this.movies,
    required this.sliderTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(sliderTitle),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeCircleImages(context, movies),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(
                  movie: movies[i],
                );
              }));
        },
        child: Container(
            padding: EdgeInsets.only(right: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  //backgroundImage: AssetImage('images/' + movies[i].poster_url),
                  backgroundImage: NetworkImage(movies[i].posterURL), // 웹 링크 이미지
                  //backgroundImage: AssetImage('images/' + movies[i].poster_url),
                  radius: 48,
                )))));
  }
  return results;
}
