class CharactersResult {
  final Info? info;
  final List<Character> characters;

  CharactersResult({this.characters = const [], this.info});

  factory CharactersResult.fromJson(Map<String, dynamic> json) {
    List<Character> characters = [];
    if (json['results'] != null) {
      json['results'].forEach((character){
        characters.add(Character.fromJson(character));
      });
    }

    return CharactersResult(characters: characters, info: json['info'] != null ? Info.fromJson(json['info']) : null);
  }
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final Location location;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    required this.image,
    required this.location,
    required this.species,
    required this.type,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        gender: json['gender'],
        image: json['image'],
        location: Location.fromJson(json['location']),
        species: json['species'],
        type: json['type'],
      );
}

class Info {
  final String? next;

  Info({this.next});

  factory Info.fromJson(Map<String, dynamic> json) => Info(next: json['next']);
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        url: json['url'],
      );
}
