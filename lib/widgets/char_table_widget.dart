import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/consts/colors.dart';
import 'package:pokemon/consts/strings.dart';

class CharTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildCharTable();
  }

  Widget _buildCharTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(80.0),
          1: FixedColumnWidth(70.0),
          2: FixedColumnWidth(70.0),
          3: FixedColumnWidth(70.0),
          4: FixedColumnWidth(70.0),
          5: FixedColumnWidth(70.0),
        },
        border: TableBorder.all(
          color: COLORS.CHAR_TAB_LINE,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(children: [
            _buildTableTitleView('个体值%5=', COLORS.CHAR_TAB_TITLE),
            _buildTableTitleView('0'),
            _buildTableTitleView('1'),
            _buildTableTitleView('2'),
            _buildTableTitleView('3'),
            _buildTableTitleView('4'),
          ]),
          TableRow(children: _buildTableCellView(0, STRINGS.HP)),
          TableRow(children: _buildTableCellView(1, STRINGS.ATK)),
          TableRow(children: _buildTableCellView(2, STRINGS.DEF)),
          TableRow(children: _buildTableCellView(3, STRINGS.SAT)),
          TableRow(children: _buildTableCellView(4, STRINGS.SDE)),
          TableRow(children: _buildTableCellView(5, STRINGS.SPD)),
          TableRow(children: [
            _buildTableTitleView('个体值%5=', COLORS.CHAR_TAB_TITLE),
            _buildTableTitleView('0'),
            _buildTableTitleView('1'),
            _buildTableTitleView('2'),
            _buildTableTitleView('3'),
            _buildTableTitleView('4'),
          ]),
        ],
      ),
    );
  }

  Widget _buildTableTitleView(String text, [Color color = Colors.white]) {
    return Container(
      color: color,
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

  List<Widget> _buildTableCellView(int row, String text) {
    return [
      Container(
        height: 96,
        color: COLORS.COLOR_MAP[text],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${text}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 96,
        color: COLORS.COLOR_MAP[text],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.CHAR_TABLE[0][row].split('\n')[0]}\n${STRINGS.CHAR_TABLE[0][row].split('\n')[1]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 96,
        color: COLORS.COLOR_MAP[text],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.CHAR_TABLE[1][row].split('\n')[0]}\n${STRINGS.CHAR_TABLE[1][row].split('\n')[1]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 96,
        color: COLORS.COLOR_MAP[text],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.CHAR_TABLE[2][row].split('\n')[0]}\n${STRINGS.CHAR_TABLE[2][row].split('\n')[1]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 96,
        color: COLORS.COLOR_MAP[text],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.CHAR_TABLE[3][row].split('\n')[0]}\n${STRINGS.CHAR_TABLE[3][row].split('\n')[1]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 96,
        color: COLORS.COLOR_MAP[text],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.CHAR_TABLE[4][row].split('\n')[0]}\n${STRINGS.CHAR_TABLE[4][row].split('\n')[1]}',
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }
}
