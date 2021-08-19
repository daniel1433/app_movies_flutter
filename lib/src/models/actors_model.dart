class Actors {
  List<Actor> _actors = [];

  Actors(List<dynamic> data) {
    for (var item in data) {
      this._actors.add(Actor.fromJson(item));
    }
  }

  List<Actor> getCast() => this._actors;
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  final profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  Actor(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      this.profilePath,
      required this.castId,
      required this.character,
      required this.creditId,
      required this.order});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"],
      profilePath: json["profile_path"],
      castId: json["cast_id"],
      character: json["character"],
      creditId: json["credit_id"],
      order: json["order"],
    );
  }

  getProfilePath() {
    if (this.profilePath == null) {
      return "https://bitsofco.de/content/images/2018/12/broken-1.png";
    } else {
      return 'https://images.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
