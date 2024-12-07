import 'package:flutter/material.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/screen/detail_screen.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  final String sliderTitle;

  BoxSlider({
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
          Text(sliderTitle,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Comic Sans MS',
            ),
          ),
          Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: makeBoxImages(context, movies),
              ))
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(
      InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(
                  movie: movies[i],
                );
              }
          ));
        },
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            //child: Image('images/' + movies[i].poster_url),
            //image: NetworkImage(widget.movie.poster_url), // 웹 링크 이미지
            child: Image.network(
              movies[i].posterURL,
            ),
          ),
        ),
      ),
    );
  }
  return results;
}
