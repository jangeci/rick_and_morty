import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/app/data/models/character.dart';
import 'package:rick_and_morty/app/data/models/request_error.dart';

class CharactersService {
  static var client = http.Client();

  static Future fetchCharacters({
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

    var res = await client.get(Uri.parse(baseUrl));
    if(res.statusCode == 200){
      return CharactersResult.fromJson(json.decode(res.body));
    } else {
      return RequestError(message: res.body.toString(), code: res.statusCode);
    }
  }
}
