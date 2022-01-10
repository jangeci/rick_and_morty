import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';
import 'package:rick_and_morty/app/modules/home/controllers/favorite_controller.dart';
import 'package:rick_and_morty/app/modules/home/controllers/home_controller.dart';

class DetailView extends GetView {
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    int id = Get.arguments['id'];
    late Character character;

    final List<Character> allCharacters = [...favoriteController.favoriteCharactersFiltered, ...homeController.characters];
    character = allCharacters.firstWhere((element) => element.id == id);


    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(character.name),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Hero(
                          child: Image.network(
                            character.image,
                            fit: BoxFit.cover,
                          ),
                          tag: id,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Obx(
                          () => IconButton(
                            icon: Icon(favoriteController.isFavorite(id) ? Icons.star : Icons.star_border),
                            onPressed: () {
                              favoriteController.setFavorite(id);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text(character.name),
                    SizedBox(height: 12),
                    Text('Species: ${character.species}'),
                    SizedBox(height: 12),
                    Text('Gender: ${character.gender}'),
                    SizedBox(height: 12),
                    Text('Status: ${character.status}'),
                    SizedBox(height: 12),
                    Text('Location: ${character.location.name}'),
                    SizedBox(height: 12),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
