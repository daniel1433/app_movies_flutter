import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actors_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import '../global/global.dart' as global;

class DetailsMoviePage extends StatelessWidget {
  final MoviesProvider movieProvider = MoviesProvider();
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(slivers: [
      _customAppBar(movie),
      SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(
            height: 10.0,
          ),
          _posterTitle(context, movie),
          _description(movie),
          _description(movie),
          _showCast(movie)
        ]),
      )
    ]));
  }

  Widget _customAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Color(0xffaf0903),
      expandedHeight: 200.00,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title,
            style: TextStyle(fontSize: 16.0, color: Color(0xffffffff))),
        background: FadeInImage(
          placeholder: AssetImage("assets/images/loading.gif"),
          image: NetworkImage(movie.getBackdropPost()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: [
        Hero(
          tag: movie.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movie.title,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.ellipsis),
            Text(movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.star_outline),
                Text(movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            )
          ],
        ))
      ]),
    ));
  }

  Widget _description(Movie movie) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _showCast(Movie movie) {
    return Container(
        child: FutureBuilder<List<Actor>>(
      future: this.movieProvider.getCast(movie.id),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) =>
          global.validSnapshot(
              snapshot, () => this._listCast(context, snapshot.data)),
    ));
  }

  Widget _listCast(BuildContext context, List<Actor>? data) {
    if (data != null) {
      return SizedBox(
        height: 200.0,
        child: PageView.builder(
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          itemCount: data.length,
          itemBuilder: (BuildContext context, i) {
            return this._cardActor(context, data[i]);
          },
        ),
      );
    } else
      return Center(
        child: Text("No found actors",
            style: Theme.of(context).textTheme.headline5),
      );
  }

  Widget _cardActor(BuildContext context, Actor actor) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePath()),
              placeholder: AssetImage('assets/images/loading.gif'),
              height: 130.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name,
              style: Theme.of(context).textTheme.subtitle2,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
