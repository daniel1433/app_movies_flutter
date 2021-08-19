import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:movies_app/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          this.movies[index].uniqueId = '${this.movies[index].id}-poster';

          return Hero(
            tag: this.movies[index].uniqueId,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'detailsMovie',
                    arguments: this.movies[index]);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: this._getItemMovie(this.movies[index])
                  // child: Image.network(
                  //   "https://via.placeholder.com/288x188",
                  //   fit: BoxFit.fill,
                  // ),
                  // child: Text(this.movies[index].toString()),
                  ),
            ),
          );
        },
        itemCount: this.movies.length,
        itemWidth: _screenSize.width * 0.7,
        // itemWidth: _screenSize.width,
        itemHeight: _screenSize.height * 0.5,
        // layout: SwiperLayout.TINDER,
        layout: SwiperLayout.STACK,
      ),
    );
  }

  Widget _getItemMovie(Movie movie) {
    // print(movie.getPosterImg());
    // return Image(
    //   image: AssetImage('assets/images/loading.gif'),
    // );
    return FadeInImage(
        placeholder: AssetImage('assets/images/loading.gif'),
        image: NetworkImage(movie.getPosterImg()));
  }
}
