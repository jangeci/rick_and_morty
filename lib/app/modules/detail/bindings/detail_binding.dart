import 'package:get/get.dart';
import 'package:rick_and_morty/app/controllers/favorite_controller.dart';

import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController(), tag: 'detail');
    Get.put<FavoriteController>(FavoriteController(), permanent: true, tag: 'fav');
  }
}
