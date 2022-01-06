import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';
import 'package:rick_and_morty/app/data/services/characters_service.dart';

class HomeController extends GetxController with StateMixin<CharactersResult> {
  CharactersService service = CharactersService();
  RxList<Character> characters = RxList<Character>();

  RxList<Character> favorites = RxList<Character>();

  var page = 1;
  var nameFilter = '';

  @override
  void onInit() {
    loadCharacters();
    super.onInit();
  }

  void resetFilters() {
    page = 1;
    nameFilter = '';
  }

  void loadCharacters() async {
    service
        .fetchCharacters(
      name: nameFilter,
      ids: null,
      page: page,
    )
        .then((response) {
      characters.addAll(response.characters);

      if (response.characters.isEmpty) {
        change(response, status: RxStatus.empty());
      } else {
        change(response, status: RxStatus.success());
      }
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void paginate() {
    //TODO
  }
}
