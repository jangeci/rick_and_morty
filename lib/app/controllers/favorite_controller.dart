import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController {
  static const String FAVORITES_KEY = 'favs';

  RxList<int>  favorites = RxList<int>();

  RxBool favoriteMode = false.obs;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  void switchMode(){
    favoriteMode.toggle();
  }

  void updateFavorites(int id){
    if(favorites.contains(id)){
      favorites.removeWhere((element) => element == id);
    } else {
      favorites.add(id);
    }

    saveFavorites();
  }

  void loadFavorites() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String tempFavs = prefs.getString(FAVORITES_KEY) ?? '';
    favorites.value = tempFavs.split(';').map(int.parse).toList();
  }

  void saveFavorites() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString(FAVORITES_KEY, favorites.join(';'));
  }

  bool isFavorite(id){
    return favorites.contains(id);
  }
}