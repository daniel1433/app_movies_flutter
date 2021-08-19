import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:movies_app/src/search/search_movie.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';
import '../global/global.dart' as global;

class HomePage extends StatelessWidget {
  final MoviesProvider moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    this.moviesProvider.getPopularMovies();

    return Scaffold(
        appBar: AppBar(
          title: Text("Movies Page"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchMovie(),
                    // query: 'Buscar película...'
                  );
                })
          ],
          backgroundColor: Color(0xff1d1d54),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_swiperCards(), _footerCards(context)],
        ));
  }

  Widget _swiperCards() {
    return FutureBuilder<List<Movie>>(
        initialData: [],
        future: this.moviesProvider.getMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return global.validSnapshot(
              snapshot, () => CardSwiper(movies: snapshot.data));
        });
  }

  Widget _footerCards(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("Popular Movies",
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            SizedBox(
              height: 5.0,
            ),
            StreamBuilder<List<Movie>>(
                // initialData: [],
                stream: this.moviesProvider.popularsMovieStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return global.validSnapshot(
                      snapshot,
                      () => MovieHorizontal(
                          movies: snapshot.data,
                          nextPage: this.moviesProvider.getPopularMovies));
                })
          ],
        ));
  }
}
