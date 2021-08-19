import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/actors_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'dart:convert';
import 'dart:async';
import '../global/global.dart' as global;

class MoviesProvider {
  int _popularPage = 0;
  List<Movie> _popularMovies = [];
  bool _loading = false;

  // Streamer
  final StreamController<List<Movie>> _popularMoviesStreamController =
      StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsMovieSink =>
      this._popularMoviesStreamController.sink.add;
  Stream<List<Movie>> get popularsMovieStream =>
      this._popularMoviesStreamController.stream;

  // Uri _getUri(String action, String complement, [bool? noSendLanguage, String? aditional]) {
  //   return Uri.parse(
  //       '${global.uri_api}/$action/$complement?api_key=${global.api_key}${noSendLanguage == null ? '&language=en-US' : ""}${aditional != null ? "&$aditional" : ""}');
  // }

  Uri _getUri(String origin, String complement,
      [Map<String, dynamic>? header]) {
    return Uri.https(global.uri_api, '/3/$origin/$complement', {
      'api_key': global.api_key,
      'language': 'en-US',
      ...(header != null ? header : {})
    });
  }

  List<Movie> _processResultMovie(var res) {
    List<Movie> result = [];

    if (res.statusCode == 200) {
      // print(res.body);
      Map<String, dynamic> dataJson = json.decode(res.body);
      result = new Movies(dataJson["results"]).getMovies();
    }
    return result;
  }

  List<Actor> _processResultActors(var res) {
    List<Actor> result = [];

    if (res.statusCode == 200) {
      // print(res.body);
      Map<String, dynamic> dataJson = json.decode(res.body);
      result = new Actors(dataJson["cast"]).getCast();
    }
    return result;
  }

  Future<List<Movie>> getMovies() async {
    final res = await http.get(this._getUri('movie', 'now_playing'));
    return this._processResultMovie(res);
  }

  Future<List<Movie>> getPopularMovies() async {
    if (this._loading == true) return [];
    this._loading = true;
    this._popularPage++;
    final res = await http.get(this
        ._getUri('movie', 'popular', {"page": this._popularPage.toString()}));

    final List<Movie> result = this._processResultMovie(res);

    this._popularMovies.addAll(result);
    this.popularsMovieSink(this._popularMovies);
    this._loading = false;
    return result;
  }

  Future<List<Movie>> getLastMovies() async {
    final res = await http.get(this._getUri('movie', 'top_rated'));
    return this._processResultMovie(res);
  }

  Future<List<Movie>> getSearchMovies(String query) async {
    print(this._getUri('search', 'movie', {"query": "find"}));
    final res =
        await http.get(this._getUri('search', 'movie', {"query": query}));
    return this._processResultMovie(res);
  }

  Future<List<Actor>> getCast(int id) async {
    final res =
        await http.get(this._getUri('movie', '${id.toString()}/credits'));
    return this._processResultActors(res);
  }

  void dispose() {
    this._popularMoviesStreamController.close();
  }
}
