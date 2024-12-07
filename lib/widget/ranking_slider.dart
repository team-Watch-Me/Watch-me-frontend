import 'package:flutter/material.dart';
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/screen/detail_screen.dart';

class RankingSliderVertical extends StatelessWidget {
  final List<Movie> movies;
  final String sliderTitle;

  RankingSliderVertical({
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
          Text(
            sliderTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return makeRankingItem(context, movies, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget makeRankingItem(BuildContext context, List<Movie> movies, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
          fullscreenDialog: true,
          builder: (BuildContext context) {
            return DetailScreen(
              movie: movies[index],
            );
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              child: Text(
                '${index + 1}  ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movies[index].posterURL,
                width: 60,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                movies[index].title,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Comic Sans MS',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}