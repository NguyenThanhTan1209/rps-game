import 'package:flutter/material.dart';

import '../data/game_match.dart';

class OptionWidget extends StatelessWidget {
  final GameChoice choice;
  const OptionWidget({super.key, required this.choice});

  @override
  Widget build(BuildContext context) {
    switch (choice) {
      case GameChoice.paper:
        return Image.asset(
          'assets/paper.png',
          width: 100,
          height: 100,
        );
      case GameChoice.scissors:
        return Image.asset(
          'assets/scissors.png',
          width: 100,
          height: 100,
        );
      case GameChoice.rock:
        return Image.asset(
          'assets/rock.png',
          width: 100,
          height: 100,
        );
      default:
        return Container();
    }
  }
}
