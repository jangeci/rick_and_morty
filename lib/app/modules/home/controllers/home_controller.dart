import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';
import 'package:rick_and_morty/app/data/services/characters_service.dart';

class HomeController extends GetxController with StateMixin<CharactersResult>, GetSingleTickerProviderStateMixin {
  CharactersService service = CharactersService();
  RxList<Character> characters = RxList<Character>();

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late TabController tabController;

  var page = 1;
  var paginationLoading = false;
  var favoriteMode = false.obs;
  var searchOpened = false.obs;

  Info? info;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    loadCharacters();
    initPagination();
    tabController.addListener(() {
      favoriteMode.value = tabController.index == 1;
    });
    super.onInit();
  }

  void search() {
    characters.clear();
    page = 1;
    loadCharacters();
  }

  @override
  void onClose() {
    scrollController.dispose();
    tabController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void initPagination() {
    scrollController.addListener(() {
      if (!status.isLoading && !paginationLoading) {
        if (scrollController.position.maxScrollExtent == scrollController.position.pixels && info?.next != null) {
          page++;
          paginationLoading = true;
          loadCharacters();
        }
      }
    });
  }

  void loadCharacters() async {
    if (!paginationLoading) {
      change(null, status: RxStatus.loading());
    }
    service.fetchCharacters(name: searchController.text, page: page).then((response) {
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

  void switchMode() {
    favoriteMode.toggle();
    if (favoriteMode.isTrue) {
      tabController.animateTo(1);
    } else {
      tabController.animateTo(0);
    }
  }

  void toggleSearch() {
    searchOpened.toggle();
  }
}
