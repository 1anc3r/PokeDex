import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/consts/colors.dart';
import 'package:pokemon/consts/numbers.dart';
import 'package:pokemon/consts/strings.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/utils/calc_util.dart';
import 'package:pokemon/views/card_in_card_widget.dart';
import 'package:pokemon/views/line_process_widget.dart';

class PokeStatWidget extends StatefulWidget {
  final PokeModel poke;

  PokeStatWidget({Key key, @required this.poke}) : super(key: key);

  @override
  PokeStatState createState() {
    return PokeStatState(poke);
  }
}

class PokeStatState extends State<PokeStatWidget>
    with SingleTickerProviderStateMixin {
  final PokeModel poke;

  PokeStatState(this.poke);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(6.0),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildSpeciesStrengthHexaView(),
          Padding(
              padding: const EdgeInsets.only(top: 96.0),
              child: Column(
                children: [
                  _buildBasePointsView(),
                  _buildSpeciesStrengthView(),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildSpeciesStrengthHexaView() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 36, bottom: 96.0, left: 96.0, right: 96.0),
      child: Stack(children: [
        CustomPaint(
          child: Container(),
          painter: HexagonTextPainter(texts: [
            '${STRINGS.HP}\n${poke.speciesStrengths[STRINGS.HP]}',
            '${STRINGS.ATK}\n${poke.speciesStrengths[STRINGS.ATK]}',
            '${STRINGS.DEF}\n${poke.speciesStrengths[STRINGS.DEF]}',
            '${STRINGS.SPD}\n${poke.speciesStrengths[STRINGS.SPD]}',
            '${STRINGS.SAT}\n${poke.speciesStrengths[STRINGS.SAT]}',
            '${STRINGS.SDE}\n${poke.speciesStrengths[STRINGS.SDE]}'
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
                poke.speciesStrengths[STRINGS.HP] / 255,
                poke.speciesStrengths[STRINGS.ATK] / 255,
                poke.speciesStrengths[STRINGS.DEF] / 255,
                poke.speciesStrengths[STRINGS.SPD] / 255,
                poke.speciesStrengths[STRINGS.SAT] / 255,
                poke.speciesStrengths[STRINGS.SDE] / 255,
              ]),
            ),
          ]),
        )
      ]),
    );
  }

  Widget _buildBasePointsView() {
    return CardInCardWidget(
      text: '取得基础点数',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Row(children: [
        _buildTextCardView('${STRINGS.HP}\n${poke.basePoints[STRINGS.HP]}',
            COLORS.COLOR_MAP[STRINGS.HP]),
        _buildTextCardView('${STRINGS.ATK}\n${poke.basePoints[STRINGS.ATK]}',
            COLORS.COLOR_MAP[STRINGS.ATK]),
        _buildTextCardView('${STRINGS.DEF}\n${poke.basePoints[STRINGS.DEF]}',
            COLORS.COLOR_MAP[STRINGS.DEF]),
        _buildTextCardView('${STRINGS.SAT}\n${poke.basePoints[STRINGS.SAT]}',
            COLORS.COLOR_MAP[STRINGS.SAT]),
        _buildTextCardView('${STRINGS.SDE}\n${poke.basePoints[STRINGS.SDE]}',
            COLORS.COLOR_MAP[STRINGS.SDE]),
        _buildTextCardView('${STRINGS.SPD}\n${poke.basePoints[STRINGS.SPD]}',
            COLORS.COLOR_MAP[STRINGS.SPD]),
      ]),
    );
  }

  Widget _buildSpeciesStrengthView() {
    return CardInCardWidget(
      text: '能力值',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        child: Table(
          columnWidths: const {
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
              _buildTableTitleView('种族值'),
              _buildTableTitleView('50级时'),
              _buildTableTitleView('100级时'),
            ]),
            TableRow(children: _buildTableCellView(STRINGS.HP)),
            TableRow(children: _buildTableCellView(STRINGS.ATK)),
            TableRow(children: _buildTableCellView(STRINGS.DEF)),
            TableRow(children: _buildTableCellView(STRINGS.SAT)),
            TableRow(children: _buildTableCellView(STRINGS.SDE)),
            TableRow(children: _buildTableCellView(STRINGS.SPD)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableTitleView(String text) {
    return Container(
      color: COLORS.COLOR_MAP[poke.types[0]],
      padding: const EdgeInsets.all(2.0),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  List<Widget> _buildTableCellView(String text) {
    return [
      LineProcessWidget(
          name: text,
          value: poke.speciesStrengths[text],
          process: poke.speciesStrengths[text] / 255,
          color: COLORS.COLOR_MAP[text]),
      Container(
        padding: const EdgeInsets.all(2.0),
        alignment: Alignment.center,
        child: Text(
            '${CalcUtil.CalcPower(1, poke.speciesStrengths[text], 0, 0, 50, 0.9)} ~ ${CalcUtil.CalcPower(1, poke.speciesStrengths[text], 31, 252, 50, 1.1)}'),
      ),
      Container(
        padding: const EdgeInsets.all(2.0),
        alignment: Alignment.center,
        child: Text(
            '${CalcUtil.CalcPower(1, poke.speciesStrengths[text], 0, 0, 100, 0.9)} ~ ${CalcUtil.CalcPower(1, poke.speciesStrengths[text], 31, 252, 100, 1.1)}'),
      ),
    ];
  }

  Widget _buildTextCardView(String text, Color color) {
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
      size.width / (2 * NUMBERS.RADICAL_THREE), // 4 : y1
      3 * size.width / (2 * NUMBERS.RADICAL_THREE), // 5 : y2
      2 * size.width / NUMBERS.RADICAL_THREE // 6 : y3
    ];

    // north
    path.moveTo(
        points[1], (1 - precents[0]) * size.width / NUMBERS.RADICAL_THREE);
    // north-east
    path.lineTo(((1 + precents[1]) / 2 * size.width),
        (2 - precents[1]) * size.width / 2 / NUMBERS.RADICAL_THREE);
    // south-east
    path.lineTo(((1 + precents[2]) / 2 * size.width),
        (2 + precents[2]) * size.width / 2 / NUMBERS.RADICAL_THREE);
    // south
    path.lineTo(
        points[1], (1 + precents[3]) * size.width / NUMBERS.RADICAL_THREE);
    // south-west
    path.lineTo(((1 - precents[4]) / 2 * size.width),
        (2 + precents[4]) * size.width / 2 / NUMBERS.RADICAL_THREE);
    // north-west
    path.lineTo((1 - precents[5]) / 2 * size.width,
        (2 - precents[5]) * size.width / 2 / NUMBERS.RADICAL_THREE);
    path.lineTo(
        points[1], (1 - precents[0]) * size.width / NUMBERS.RADICAL_THREE);
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
      size.width / (2 * NUMBERS.RADICAL_THREE), // 4 : y1
      3 * size.width / (2 * NUMBERS.RADICAL_THREE), // 5 : y2
      2 * size.width / NUMBERS.RADICAL_THREE // 6 : y3
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
      size.width / (2 * NUMBERS.RADICAL_THREE), // 4 : y1
      3 * size.width / (2 * NUMBERS.RADICAL_THREE), // 5 : y2
      2 * size.width / NUMBERS.RADICAL_THREE // 6 : y3
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
