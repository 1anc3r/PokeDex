import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class LineProcessWidget extends StatelessWidget {
  LineProcessWidget({this.name, this.value, this.process, this.color});

  final String name;
  final int value;
  final double process;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return _buildItemKeyValueCardView(name, value, process, color);
  }

  Widget _buildItemKeyValueCardView(
      String key, int value, double process, Color color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(children: [
        Text(sprintf('%s  %03d  ', [key, value])),
        Container(
          height: 12,
          width: 100,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(color),
            value: process,
          ),
        )
      ]),
    );
  }
}
