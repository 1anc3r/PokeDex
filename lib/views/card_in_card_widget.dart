import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInCardWidget extends StatelessWidget {
  CardInCardWidget({this.text, this.color, this.child});

  final String text;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _buildItemKeyValueCardView(text, color, child);
  }

  Widget _buildItemKeyValueCardView(String title, Color color, Widget child) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: color, // Constants.POKEMON_COLOR_MAP[poke.types[0]]
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Card(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
