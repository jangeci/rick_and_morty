import 'package:get/get.dart';
import 'package:rick_and_morty/app/controllers/favorite_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), tag: 'home');
    Get.put<FavoriteController>(FavoriteController(), permanent: true, tag: 'fav');
  }
}
