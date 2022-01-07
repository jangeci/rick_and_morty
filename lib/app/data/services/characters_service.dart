import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';

class CharactersService extends GetConnect {
  Future<CharactersResult> fetchCharacters({
    String? name,
    int? page,
  }) async {
    String baseUrl = 'https://rickandmortyapi.com/api/character/';

    if (page != null) {
      baseUrl += '?page=$page';
    }

    if (name != null) {
      baseUrl += '${page != null ? '&' : '?'}name=$name';
    }

    final response = await get(baseUrl);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return CharactersResult.fromJson(response.body);
    }
  }

  Future<List<Character>> fetchCharactersById({
    List<int>? ids,
  }) async {
    String baseUrl = 'https://rickandmortyapi.com/api/character/';
    List<Character> characters = [];
    if (ids != null) {
      baseUrl += ids.join(',');
    } else {
      return characters;
    }

    final response = await get(baseUrl);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      response.body.forEach((character) {
        characters.add(Character.fromJson(character));
      });
      return characters;
    }
  }
}
