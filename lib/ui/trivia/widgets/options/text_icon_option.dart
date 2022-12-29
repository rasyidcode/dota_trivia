import 'package:dota_trivia/constants/apis.dart';
import 'package:flutter/material.dart';

enum TextIconType { moveSpeed, attack, armor }

class TextIconOption extends StatelessWidget {
  const TextIconOption({super.key, this.content, this.type});

  final String? content;
  final TextIconType? type;

  @override
  Widget build(BuildContext context) {
    String? iconUrl;

    if (type == TextIconType.moveSpeed) {
      iconUrl =
          '${Apis.steamAssetURL}/apps/dota2/images/dota_react/heroes/stats/icon_movement_speed.png';
    } else if (type == TextIconType.attack) {
      iconUrl =
          '${Apis.steamAssetURL}/apps/dota2/images/dota_react/heroes/stats/icon_damage.png';
    } else if (type == TextIconType.armor) {
      iconUrl =
          '${Apis.steamAssetURL}/apps/dota2/images/dota_react/heroes/stats/icon_armor.png';
    }
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconUrl == null
              ? Container(
                  color: Colors.white,
                  height: 22.5,
                  width: 22.5,
                )
              : Image.network(
                  iconUrl,
                  width: 22.5,
                  height: 22.5,
                ),
          const SizedBox(width: 8.0),
          Text(
            content ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
