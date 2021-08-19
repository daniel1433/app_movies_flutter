import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import '../global/global.dart' as global;

class SearchMovie extends SearchDelegate {
  List<String> movies = [
    "Superman",
    "Viuda negra",
    "Antman",
    "Spiderman",
    "Daemon slayer",
    "Rapido y furioso 9",
    "Hotel transilvania",
    "Minions",
    "Deadpool"
  ];

  final MoviesProvider moviesProvider = MoviesProvider();

  List<String> moviesRecent = ["Minions", "Daemon slayer", "Daemon slayer"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Lista de acciones
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // El icono de la derecha
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea una vista drento del search que muestra los resultados seleccionados
    return Container();
  }

  // *************************
  // Local test
  // *************************
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe
  //   List<String> listShowed = (query.isEmpty)
  //       ? this.moviesRecent
  //       : this
  //           .movies
  //           .where(
  //               (movie) => movie.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemCount: listShowed.length,
  //     itemBuilder: (BuildContext context, int i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie_creation),
  //         title: Text(listShowed[i]),
  //       );
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // print(this.moviesProvider.getSearchMovies());
    if (query.isEmpty) {
      return _resultFutureBuilderSuggestions(
          context, this.moviesProvider.getLastMovies);
    } else
      return _resultFutureBuilderSuggestions(
          context, () => this.moviesProvider.getSearchMovies(query));
  }

  Widget _resultFutureBuilderSuggestions(
      BuildContext context, Function() myFuture) {
    return FutureBuilder<List<Movie>>(
        future: myFuture(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          return global.validSnapshot(
              snapshot, () => _orderResult(context, snapshot.data));
        });
  }

  Widget _orderResult(BuildContext context, List<Movie>? data) {
    if (data != null) {
      return ListView(
        children: data.map((Movie movie) {
          movie.uniqueId = "${movie.id}-search";

          return Hero(
            tag: movie.uniqueId,
            child: ListTile(
              leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/images/loading.gif'),
                  width: 50.0,
                  fit: BoxFit.contain),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'detailsMovie', arguments: movie);
              },
            ),
          );
        }).toList(),
      );
    } else
      return Container();
  }
}
