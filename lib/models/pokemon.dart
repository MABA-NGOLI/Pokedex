/// Model représentant un film récupéré de l'API OMDB.
class Movie {
  final String id;
  final String name;
  final String supertype;
  final List<String>? subtypes;
  final String level;
  final String hp;
  final List<String>? types;
  final String? poster;


  Movie({
    required this.id,
    required this.name,
    required this.supertype,
    required this.subtypes,
    required this.level,
    required this.hp,
    required this.types,
    this.poster

  });

  /// Factory constructor pour créer une instance de Movie à partir d'un JSON.
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      name: json['Name'] ?? '',
      supertype: json['Supertype'] ?? '',
      subtypes: json['Subtypes'] ?? '',
      level: json['Level'] ?? '',
      hp: json['Hp'] ?? '',
      types: json['Types'] ?? '',
      poster: json['Poster'] != null && json['Poster'] != 'N/A' ? json['Poster'] : null,
    );
  }

  /// Conversion d'une instance Movie en JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Supertype': supertype,
      'Subtypes': subtypes,
      'Level': level,
      'Hp': hp,
      'types': types,
      'Poster': poster,
    };
  }
}
