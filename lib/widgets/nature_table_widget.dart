import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/consts/colors.dart';
import 'package:pokemon/consts/strings.dart';

class NatureTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildNatureTable();
  }

  Widget _buildNatureTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(80.0),
          1: FixedColumnWidth(70.0),
          2: FixedColumnWidth(70.0),
          3: FixedColumnWidth(70.0),
          4: FixedColumnWidth(70.0),
        },
        border: TableBorder.all(
          color: COLORS.NATURE_TAB_LINE,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        children: [
          TableRow(children: [
            _buildTableTitleView('性格'),
            _buildTableTitleView('加成能力'),
            _buildTableTitleView('减成能力'),
            _buildTableTitleView('喜欢口味'),
            _buildTableTitleView('讨厌口味'),
          ]),
          TableRow(children: _buildTableCellView(0)),
          TableRow(children: _buildTableCellView(1)),
          TableRow(children: _buildTableCellView(2)),
          TableRow(children: _buildTableCellView(3)),
          TableRow(children: _buildTableCellView(4)),
          TableRow(children: _buildTableCellView(5)),
          TableRow(children: _buildTableCellView(6)),
          TableRow(children: _buildTableCellView(7)),
          TableRow(children: _buildTableCellView(8)),
          TableRow(children: _buildTableCellView(9)),
          TableRow(children: _buildTableCellView(10)),
          TableRow(children: _buildTableCellView(11)),
          TableRow(children: _buildTableCellView(12)),
          TableRow(children: _buildTableCellView(13)),
          TableRow(children: _buildTableCellView(14)),
          TableRow(children: _buildTableCellView(15)),
          TableRow(children: _buildTableCellView(16)),
          TableRow(children: _buildTableCellView(17)),
          TableRow(children: _buildTableCellView(18)),
          TableRow(children: _buildTableCellView(19)),
          TableRow(children: _buildTableCellView(20)),
          TableRow(children: _buildTableCellView(21)),
          TableRow(children: _buildTableCellView(22)),
          TableRow(children: _buildTableCellView(23)),
          TableRow(children: _buildTableCellView(24)),
          TableRow(children: [
            _buildTableTitleView('性格'),
            _buildTableTitleView('加成能力'),
            _buildTableTitleView('减成能力'),
            _buildTableTitleView('喜欢口味'),
            _buildTableTitleView('讨厌口味'),
          ]),
        ],
      ),
    );
  }

  Widget _buildTableTitleView(String text) {
    return Container(
      color: COLORS.NATURE_TAB_TITLE,
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

  List<Widget> _buildTableCellView(int row) {
    return [
      Container(
        height: 48,
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.NATURE_TABLE[row][0].split('\n')[0]}\n${STRINGS.NATURE_TABLE[row][0].split('\n')[1]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 48,
        color: COLORS.COLOR_MAP[STRINGS.NATURE_TABLE[row][1]],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.NATURE_TABLE[row][1]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 48,
        color: COLORS.COLOR_MAP[STRINGS.NATURE_TABLE[row][2]],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.NATURE_TABLE[row][2]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 48,
        color: COLORS.COLOR_MAP[STRINGS.NATURE_TABLE[row][3]],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.NATURE_TABLE[row][3]}',
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 48,
        color: COLORS.COLOR_MAP[STRINGS.NATURE_TABLE[row][4]],
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          '${STRINGS.NATURE_TABLE[row][4]}',
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }
}
