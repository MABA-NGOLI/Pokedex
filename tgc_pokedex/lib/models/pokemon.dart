// models/pokemon.dart

class PokemonCard {
  final String id;
  final String name;
  final String? supertype;
  final String? hp;
  final String? imageSmall;
  final String? imageLarge;

  PokemonCard({
    required this.id,
    required this.name,
    this.supertype,
    this.hp,
    this.imageSmall,
    this.imageLarge,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      supertype: json['supertype'],
      hp: json['hp'],
      imageSmall: json['images']?['small'],
      imageLarge: json['images']?['large'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'supertype': supertype,
      'hp': hp,
      'images': {
        'small': imageSmall,
        'large': imageLarge,
      }
    };
  }
}