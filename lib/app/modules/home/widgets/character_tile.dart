import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/data/models/character.dart';

class CharacterTile extends StatelessWidget {
  final Character character;

  const CharacterTile({required this.character, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.only(
        bottom: 12,
        left: 12,
        right: 12,
      ),
      child: Card(
        child: Row(
          children: [
            SizedBox(width: 12),
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(character.image),
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
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {
                    //TODO favorite
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
