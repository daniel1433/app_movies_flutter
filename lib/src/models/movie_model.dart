class Movies {
  List<Movie> _listMovies = [];
  Movies(List<dynamic> data) {
    for (var item in data) {
      _listMovies.add(Movie.fromJson(item));
    }
  }

  getMovies() => this._listMovies;
}

class Movie {
  String uniqueId = "";

  bool adult;
  final backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  final posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"].cast<int>(),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"] / 1,
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"] / 1,
      voteCount: json["vote_count"],
    );
  }

  getPosterImg() {
    // https://bitsofco.de/content/images/2018/12/broken-1.png
    if (posterPath == null) {
      return 'https://bitsofco.de/content/images/2018/12/broken-1.png';
    } else
      return 'https://images.tmdb.org/t/p/w500/$posterPath';
  }

  getBackdropPost() {
    if (backdropPath == null) {
      return 'https://bitsofco.de/content/images/2018/12/broken-1.png';
    } else
      return 'https://images.tmdb.org/t/p/w500/$backdropPath';
  }
}
