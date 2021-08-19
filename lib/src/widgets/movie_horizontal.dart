import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;
  final PageController _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  MovieHorizontal({required this.movies, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    this._pageController.addListener(() {
      if (this._pageController.position.pixels >=
          (this._pageController.position.maxScrollExtent - 200)) {
        this.nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        // pageSnapping: false, // Quita el efecto de magneto en el swipe horizontal
        controller: this._pageController,
        // children: _cardItems(context),
        itemCount: this.movies.length,
        itemBuilder: (BuildContext context, int i) {
          return this._cardItems(context, this.movies[i]);
        },
      ),
    );
  }

  Widget _cardItems(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-horizontal';

    Widget card = Container(
        // margin: EdgeInsets.only(right: 15.0),
        child: Column(
      children: [
        Hero(
          tag: movie.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage("assets/images/loading.gif"),
              image: NetworkImage(movie.getPosterImg()),
              fit: BoxFit.cover,
              height: 130.0,
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    ));

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, "detailsMovie", arguments: movie);
      },
    );
  }
}
