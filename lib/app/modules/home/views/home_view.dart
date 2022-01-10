import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/app/modules/home/controllers/favorite_controller.dart';
import 'package:rick_and_morty/app/modules/home/widgets/character_tile.dart';
import 'package:rick_and_morty/app/modules/home/widgets/loading_tile.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    FavoriteController favoriteController = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            controller.toggleSearch(context);
          },
        ),
        title: Obx(
          () => Text(controller.favoriteMode.value == false ? 'All characters' : 'Favorites'),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(controller.favoriteMode.value == false ? Icons.star_border : Icons.star),
              onPressed: () {
                controller.switchMode();
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => AnimatedContainer(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(),
              duration: Duration(milliseconds: 300),
              height: controller.searchOpened.isTrue ? 60 : 0,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (text) {
                    controller.search();
                    favoriteController.setFilter(filter: text);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        if (controller.searchController.text == '') {
                          controller.toggleSearch(context);
                        } else {
                          controller.searchController.text = '';
                          controller.search();
                          favoriteController.setFilter(filter: '');
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
                length: controller.tabController.length,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    controller.obx(
                      (data) => ListView.builder(
                        padding: const EdgeInsets.only(top: 12),
                        controller: controller.scrollController,
                        itemCount: controller.characters.length,
                        itemBuilder: (context, index) {
                          if (controller.characters.length - 1 == index && controller.info?.next != null) {
                            return Column(
                              children: [
                                CharacterTile(
                                  character: controller.characters[index],
                                ),
                                LoadingTile()
                              ],
                            );
                          }
                          return CharacterTile(character: controller.characters[index]);
                        },
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
                      onLoading: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            LoadingTile(),
                            LoadingTile(),
                            LoadingTile(),
                          ],
                        ),
                      ),
                    ),
                    favoriteController.obx(
                      (data) => ListView.builder(
                        padding: const EdgeInsets.only(top: 12),
                        itemCount: favoriteController.favoriteCharactersFiltered.length,
                        itemBuilder: (context, index) {
                          return CharacterTile(character: favoriteController.favoriteCharactersFiltered[index]);
                        },
                      ),
                      onEmpty: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'No favorites found',
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
                      onLoading: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            LoadingTile(),
                            LoadingTile(),
                            LoadingTile(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
