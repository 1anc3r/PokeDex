import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon_model.dart';
import 'package:pokemon/utils/calc_util.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/widgets/card_in_card_widget.dart';
import 'package:pokemon/widgets/line_process_widget.dart';

class PokemonStatWidget extends StatefulWidget {
  final PokemonModel pokemon;

  PokemonStatWidget({Key key, @required this.pokemon}) : super(key: key);

  @override
  PokemonStatState createState() {
    return PokemonStatState(pokemon);
  }
}

class PokemonStatState extends State<PokemonStatWidget>
    with SingleTickerProviderStateMixin {
  final PokemonModel pokemon;

  PokemonStatState(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSpeciesStrengthHexaMap(),
        Padding(
            padding: const EdgeInsets.only(
                top: 96.0, left: 6.0, right: 6.0, bottom: 6.0),
            child: Column(
              children: [
                _buildBasePoints(),
                _buildSpeciesStrength(),
              ],
            )),
      ],
    );
  }

  Widget _buildSpeciesStrengthHexaMap() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 36, bottom: 96.0, left: 96.0, right: 96.0),
      child: Stack(children: [
        CustomPaint(
          child: Container(),
          painter: HexagonTextPainter(texts: [
            '${Constants.HP}\n${pokemon.speciesStrengths[Constants.HP]}',
            '${Constants.ATK}\n${pokemon.speciesStrengths[Constants.ATK]}',
            '${Constants.DEF}\n${pokemon.speciesStrengths[Constants.DEF]}',
            '${Constants.SPD}\n${pokemon.speciesStrengths[Constants.SPD]}',
            '${Constants.SAT}\n${pokemon.speciesStrengths[Constants.SAT]}',
            '${Constants.SDE}\n${pokemon.speciesStrengths[Constants.SDE]}'
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(children: [
            CustomPaint(
              child: Container(),
              painter: HexagonClipPainter(
                  paintColor: Colors.grey[200], precents: [1, 1, 1, 1, 1, 1]),
            ),
            CustomPaint(
              child: Container(),
              painter: HexagonLinePainter(),
            ),
            CustomPaint(
              child: Container(),
              painter:
                  HexagonClipPainter(paintColor: Color(0x80C39CD8), precents: [
                pokemon.speciesStrengths[Constants.HP] / 255,
                pokemon.speciesStrengths[Constants.ATK] / 255,
                pokemon.speciesStrengths[Constants.DEF] / 255,
                pokemon.speciesStrengths[Constants.SPD] / 255,
                pokemon.speciesStrengths[Constants.SAT] / 255,
                pokemon.speciesStrengths[Constants.SDE] / 255,
              ]),
            ),
          ]),
        )
      ]),
    );
  }

  Widget _buildBasePoints() {
    return CardInCardWidget(
      text: '取得基础点数',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Row(children: [
        _buildTextCard('${Constants.HP}\n${pokemon.basePoints[Constants.HP]}',
            Constants.POKEMON_COLOR_MAP[Constants.HP]),
        _buildTextCard('${Constants.ATK}\n${pokemon.basePoints[Constants.ATK]}',
            Constants.POKEMON_COLOR_MAP[Constants.ATK]),
        _buildTextCard('${Constants.DEF}\n${pokemon.basePoints[Constants.DEF]}',
            Constants.POKEMON_COLOR_MAP[Constants.DEF]),
        _buildTextCard('${Constants.SAT}\n${pokemon.basePoints[Constants.SAT]}',
            Constants.POKEMON_COLOR_MAP[Constants.SAT]),
        _buildTextCard('${Constants.SDE}\n${pokemon.basePoints[Constants.SDE]}',
            Constants.POKEMON_COLOR_MAP[Constants.SDE]),
        _buildTextCard('${Constants.SPD}\n${pokemon.basePoints[Constants.SPD]}',
            Constants.POKEMON_COLOR_MAP[Constants.SPD]),
      ]),
    );
  }

  Widget _buildSpeciesStrength() {
    return CardInCardWidget(
      text: '能力值',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Card(
        child: Table(
          columnWidths: const {
            //列宽
            0: FixedColumnWidth(180.0),
            1: FixedColumnWidth(70.0),
            2: FixedColumnWidth(70.0),
          },
          border: TableBorder.all(
            color: Colors.grey[200],
            width: 2.0,
            style: BorderStyle.solid,
          ),
          children: [
            TableRow(children: [
              Container(
                color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                child: Text(
                  '种族值',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                child: Text(
                  '50级时',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                child: Text(
                  '100级时',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
            TableRow(children: _buildTableRowView(Constants.HP)),
            TableRow(children: _buildTableRowView(Constants.ATK)),
            TableRow(children: _buildTableRowView(Constants.DEF)),
            TableRow(children: _buildTableRowView(Constants.SAT)),
            TableRow(children: _buildTableRowView(Constants.SDE)),
            TableRow(children: _buildTableRowView(Constants.SPD)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTableRowView(String text) {
    return [
      LineProcessWidget(
          keyword: text,
          valueword: pokemon.speciesStrengths[text],
          process: pokemon.speciesStrengths[text] / 255,
          color: Constants.POKEMON_COLOR_MAP[text]),
      Container(
        alignment: Alignment.center,
        child: Text(
            '${CalcUtil.CalcPower(1, pokemon.speciesStrengths[text], 0, 0, 50, 0.9)} ~ ${CalcUtil.CalcPower(1, pokemon.speciesStrengths[text], 31, 252, 50, 1.1)}'),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            '${CalcUtil.CalcPower(1, pokemon.speciesStrengths[text], 0, 0, 100, 0.9)} ~ ${CalcUtil.CalcPower(1, pokemon.speciesStrengths[text], 31, 252, 100, 1.1)}'),
      ),
    ];
  }

  Widget _buildTextCard(String text, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 2, bottom: 2, left: 8.0, right: 8.0),
        child: Text(
          '$text',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class HexagonClipPainter extends CustomPainter {
  Color paintColor;
  List<double> precents = [];

  HexagonClipPainter(
      {this.paintColor, this.precents = const [1, 1, 1, 1, 1, 1]});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.color = paintColor;
    _paint.style = PaintingStyle.fill;

    Path path = Path();

    List<double> points = [
      0, // 0 : x0
      size.width / 2, // 1 : x1
      size.width, //  // 2 : x2
      0, // 3 : y0
      size.width / (2 * Constants.RADICAL_THREE), // 4 : y1
      3 * size.width / (2 * Constants.RADICAL_THREE), // 5 : y2
      2 * size.width / Constants.RADICAL_THREE // 6 : y3
    ];

    // north
    path.moveTo(
        points[1], (1 - precents[0]) * size.width / Constants.RADICAL_THREE);
    // north-east
    path.lineTo(((1 + precents[1]) / 2 * size.width),
        (2 - precents[1]) * size.width / 2 / Constants.RADICAL_THREE);
    // south-east
    path.lineTo(((1 + precents[2]) / 2 * size.width),
        (2 + precents[2]) * size.width / 2 / Constants.RADICAL_THREE);
    // south
    path.lineTo(
        points[1], (1 + precents[3]) * size.width / Constants.RADICAL_THREE);
    // south-west
    path.lineTo(((1 - precents[4]) / 2 * size.width),
        (2 + precents[4]) * size.width / 2 / Constants.RADICAL_THREE);
    // north-west
    path.lineTo((1 - precents[5]) / 2 * size.width,
        (2 - precents[5]) * size.width / 2 / Constants.RADICAL_THREE);
    path.lineTo(
        points[1], (1 - precents[0]) * size.width / Constants.RADICAL_THREE);
    path.close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HexagonLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.color = Colors.white;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeCap = StrokeCap.round;
    _paint.strokeWidth = 2.0;

    Path path = Path();

    List<double> points = [
      0, // 0 : x0
      size.width / 2, // 1 : x1
      size.width, //  // 2 : x2
      0, // 3 : y0
      size.width / (2 * Constants.RADICAL_THREE), // 4 : y1
      3 * size.width / (2 * Constants.RADICAL_THREE), // 5 : y2
      2 * size.width / Constants.RADICAL_THREE // 6 : y3
    ];

    canvas.drawLine(
        Offset(points[1], points[3]), Offset(points[1], points[6]), _paint);
    canvas.drawLine(
        Offset(points[2], points[4]), Offset(points[0], points[5]), _paint);
    canvas.drawLine(
        Offset(points[2], points[5]), Offset(points[0], points[4]), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HexagonTextPainter extends CustomPainter {
  List<String> texts = [];

  HexagonTextPainter({this.texts = const ['1', '2', '3', '4', '5', '6']});

  @override
  void paint(Canvas canvas, Size size) {
    List<double> points = [
      0, // 0 : x0
      size.width / 2, // 1 : x1
      size.width, //  // 2 : x2
      0, // 3 : y0
      size.width / (2 * Constants.RADICAL_THREE), // 4 : y1
      3 * size.width / (2 * Constants.RADICAL_THREE), // 5 : y2
      2 * size.width / Constants.RADICAL_THREE // 6 : y3
    ];

    _paintText(canvas, size, texts[0], points[1] - 12, points[3] - 18);
    _paintText(canvas, size, texts[1], points[2] - 12, points[4] - 12);
    _paintText(canvas, size, texts[2], points[2] - 12, points[5] - 12);
    _paintText(canvas, size, texts[3], points[1] - 12, points[6] - 18);
    _paintText(canvas, size, texts[4], points[0] - 12, points[5] - 12);
    _paintText(canvas, size, texts[5], points[0] - 12, points[4] - 12);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _paintText(Canvas canvas, Size size, String text, double dx, double dy) {
    TextPainter _painter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width);
    _painter.paint(canvas, Offset(dx, dy));
  }
}
