import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';
import 'package:rick_and_morty/app/data/services/characters_service.dart';

class HomeController extends GetxController with StateMixin<CharactersResult> {
  CharactersService service = CharactersService();
  RxList<Character> characters = RxList<Character>();
  RxList<Character> favorites = RxList<Character>();

  ScrollController scrollController = ScrollController();
  ScrollController favoriteController = ScrollController();

  var page = 1;
  var nameFilter = '';
  var paginationLoading = false;

  Info? info;

  @override
  void onInit() {
    loadCharacters();
    initPagination();
    super.onInit();
  }

  void resetFilters() {
    page = 1;
    nameFilter = '';
  }

  void initPagination(){
    scrollController.addListener(() {
      if(!status.isLoading && !paginationLoading){
        if(scrollController.position.maxScrollExtent == scrollController.position.pixels && info?.next != null){
          page++;
          paginationLoading = true;
          loadCharacters();
        }
      }
    });
  }

  void loadCharacters() async {
    if(!paginationLoading){
      change(null, status: RxStatus.loading());
    }
    service
        .fetchCharacters(
      name: nameFilter,
      ids: null, //TODO
      page: page,
    )
        .then((response) {
      characters.addAll(response.characters);
      info = response.info;
      paginationLoading = false;
      if (characters.isEmpty) {
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
