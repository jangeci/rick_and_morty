import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rick_and_morty/app/controllers/favorite_controller.dart';
import 'package:rick_and_morty/app/modules/home/widgets/character_tile.dart';
import 'package:rick_and_morty/app/modules/home/widgets/loading_tile.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(), tag: 'home');
    FavoriteController favController = Get.put(FavoriteController(), tag: 'fav');

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(favController.favoriteMode.value == false ? 'All characters' : 'Favorites'),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(favController.favoriteMode.value == false ? Icons.star_border : Icons.star),
              onPressed: () {
                favController.switchMode();
              },
            ),
          )
        ],
      ),
      body: homeController.obx(
        (data) => Column(
          children: [
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                controller: homeController.scrollController,
                itemCount: data!.characters.length,
                itemBuilder: (context, index) {
                  if (data.info?.next != null && index == data.characters.length - 1 && homeController.status.isLoading) {
                    return Column(
                      children: [
                        CharacterTile(character: data.characters[index]),
                        LoadingTile()
                      ],
                    );
                  }
                  return CharacterTile(character: data.characters[index]);
                },
              ),
            ),
          ],
        ),
        onEmpty: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'No characters matching your criteria were found',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ),
        onError: (error) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(error.toString(), style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
          ));
        },
        onLoading: Column(
          children: [
            SizedBox(height: 12),
            LoadingTile(),
            LoadingTile(),
            LoadingTile(),
          ],
        ),
      ),
    );
  }
}
