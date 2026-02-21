/// Model représentant un film récupéré de l'API OMDB.
class PokemonCard {
  final String id;
  final String name;
  final String? supertype;
  final String? hp;
  final String? image;

  PokemonCard({
    required this.id,
    required this.name,
    this.supertype,
    this.hp,
    this.image,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'] ?? '',
      name: json['Name'] ?? '',
      supertype: json['Supertype'],
      hp: json['Hp'],
      image: json['Images']?['small'],
    );
  }

  /// Conversion d'une instance Movie en JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Supertype': supertype,
      'Hp': hp,
      'Image': image


    };
  }
}
