import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/utils/constants.dart';

class PokeBallWidget extends StatefulWidget {
  PokeBallWidget({Key key}) : super(key: key);

  @override
  PokeBallState createState() {
    return PokeBallState();
  }
}

class PokeBallState extends State<PokeBallWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(),
      painter: PokemonBallPainter(),
    );
  }
}

class PokemonBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.color = Colors.white;
    _paint.style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.width / 2), size.width / 2, _paint);

    _paint.color = Colors.red;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = size.width / 18;

    canvas.drawCircle(
        Offset(size.width / 2, size.width / 2), size.width / 2, _paint);

    canvas.drawLine(
        Offset(size.width / 2 - size.width * Constants.RADICAL_THREE / 4,
            size.width * 3 / 4),
        Offset(size.width / 2 + size.width * Constants.RADICAL_THREE / 4,
            size.width / 4),
        _paint);

    _paint.color = Colors.white;
    _paint.style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.width / 2), size.width / 6, _paint);

    _paint.color = Colors.red;
    _paint.style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(size.width / 2, size.width / 2), size.width / 6, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}