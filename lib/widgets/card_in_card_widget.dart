import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInCardWidget extends StatelessWidget {
  CardInCardWidget({this.text, this.color, this.child});

  final String text;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _buildItemKeyValueCard(text, color, child);
  }

  _buildItemKeyValueCard(String title, Color color, Widget child) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: color, // Constants.POKEMON_COLOR_MAP[poke.types[0]]
        child: Column(children: [
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
