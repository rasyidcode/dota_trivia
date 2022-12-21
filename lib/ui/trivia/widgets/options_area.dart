import 'package:dota_trivia/ui/trivia/trivia_page.dart';
import 'package:flutter/material.dart';

class OptionsArea extends StatelessWidget {
  const OptionsArea({super.key});

  LinearGradient _activeOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blueGrey.withRed(70).withGreen(130).withBlue(130),
        Colors.blueGrey.withRed(70).withGreen(130).withBlue(130),
      ],
    );
  }

  LinearGradient _selectedOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.red.withRed(130).withOpacity(0.3),
        Colors.red.withRed(130).withOpacity(0.9),
      ],
    );
  }

  LinearGradient _incorrectOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.red.withRed(190).withOpacity(0.4),
        Colors.red.withRed(190),
        Colors.red.withRed(235).withGreen(120).withBlue(60),
      ],
    );
  }

  LinearGradient _correctOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.red.withRed(170).withOpacity(0.3),
        Colors.red.withRed(170).withOpacity(0.9),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: ['a', 'b', 'c', 'd'].map((label) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white54.withOpacity(0.3),
                width: 1.3,
              ),
              gradient: _incorrectOptionGradient(),
            ),
            width: MediaQuery.of(context).size.width / 2 - (8 * 2 - 4),
            height: 80.0,
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:
                            Colors.red.withRed(255).withGreen(180).withBlue(90),
                      ),
                ),
                Center(
                  child: Text(
                    'Phantom Lancer',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                if (false)
                  const Positioned(
                    bottom: 0,
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  )
                else
                  Positioned(
                    bottom: 0,
                    child: Icon(
                      Icons.close,
                      color:
                          Colors.red.withRed(255).withGreen(175).withBlue(90),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
