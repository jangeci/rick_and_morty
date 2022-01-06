import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';

class CharactersService extends GetConnect {
  Future<CharactersResult> fetchCharacters({
    String? name,
    List<int>? ids,
    int? page,
  }) async {
    String baseUrl = 'https://rickandmortyapi.com/api/character/';
    if (page != null) {
      baseUrl += '?page=$page';
    }

    if (name != null) {
      baseUrl += '${page != null ? '&' : '?'}page=$page';
    }

    if (ids != null) {
      baseUrl += ids.join(',');
    }

    final response = await get(baseUrl);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return CharactersResult.fromJson(response.body);
    }
  }
}
