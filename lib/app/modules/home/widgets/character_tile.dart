import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/app/data/models/character.dart';
import 'package:rick_and_morty/app/modules/home/controllers/favorite_controller.dart';
import 'package:rick_and_morty/app/routes/app_pages.dart';

class CharacterTile extends StatelessWidget {
  final Character character;

  const CharacterTile({required this.character, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteController controller = Get.find();

    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.only(
        bottom: 6,
        left: 12,
        right: 12,
      ),
      child: Card(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.DETAIL, arguments: {'id': character.id});
            },
            child: Row(
              children: [
                SizedBox(width: 12),
                Hero(
                  tag: character.id,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(character.image),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text('Species: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                          Text(character.species, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Obx(
                      () => IconButton(
                        icon: Icon(controller.isFavorite(character.id) ? Icons.star : Icons.star_border),
                        onPressed: () {
                          controller.setFavorite(character.id);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
