import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rick_and_morty/app/controllers/favorite_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    FavoriteController favController = Get.put(FavoriteController(), tag: 'fav');

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
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
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
