import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';
import 'package:rick_and_morty/app/data/services/characters_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController with StateMixin<List<Character>> {
  static const String FAVORITES_KEY = 'favs';

  CharactersService service = CharactersService();

  RxList<int> favoritesId = RxList<int>();
  final RxList<Character> _favoriteCharacters = RxList<Character>();
  RxList<Character> favoriteCharactersFiltered = RxList<Character>();

  bool disableLoading = false;

  var nameFilter = '';

  @override
  void onInit() {
    loadFavoriteIds().then((value) => loadCharacters());
    super.onInit();
  }

  void setFilter({String filter = ''}){
    nameFilter = filter;
    _filter();
  }

  void _filter() {
    favoriteCharactersFiltered.clear();
    favoriteCharactersFiltered.addAll(_favoriteCharacters);
    favoriteCharactersFiltered.removeWhere((element) => !element.name.isCaseInsensitiveContains(nameFilter));
    update();
  }

  Future loadCharacters() async {
    if (!disableLoading) {
      change(null, status: RxStatus.loading());
    }
    service.fetchCharactersById(ids: favoritesId).then((response) {
      _favoriteCharacters.value = response;
      if (_favoriteCharacters.isEmpty) {
        change(response, status: RxStatus.empty());
      } else {
        change(response, status: RxStatus.success());
        _filter();
      }
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void setFavorite(int id) {
    if (favoritesId.contains(id)) {
      favoritesId.removeWhere((element) => element == id);
      disableLoading = true;
    } else {
      favoritesId.add(id);
    }

    saveFavoriteId();
    loadCharacters().then((value) {
      disableLoading = false;
    });
  }

  Future loadFavoriteIds() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String tempFavs = prefs.getString(FAVORITES_KEY) ?? '';
    if (tempFavs != '') {
      favoritesId.value = tempFavs.split(';').map(int.parse).toList();
    }
  }

  void saveFavoriteId() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if (favoritesId.isNotEmpty) {
      prefs.setString(FAVORITES_KEY, favoritesId.join(';'));
    }
  }

  bool isFavorite(id) {
    return favoritesId.contains(id);
  }
}
