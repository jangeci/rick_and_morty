import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';

class HomeController extends GetxController with StateMixin<CharactersResult>{

  RxList<Character> characters = RxList<Character>();
  var info;

  RxList<Character> favorites = RxList<Character>();

  var page = 1;
  var nameFilter = '';

  @override
  void onInit() {
    loadCharacters();
    super.onInit();
  }

  void resetFilters(){
    page = 1;
    nameFilter = '';
  }

  void loadCharacters() async {

  }
}
