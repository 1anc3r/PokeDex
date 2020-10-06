import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/consts/colors.dart';
import 'package:pokemon/models/move_model.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:sprintf/sprintf.dart';

import 'card_in_card_widget.dart';

class PokeMoveWidget extends StatelessWidget {
  PokeMoveWidget({this.poke});

  final PokeModel poke;

  @override
  Widget build(BuildContext context) {
    return _buildMoveList();
  }

  Widget _buildMoveList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(6.0),
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          _buildTableListView('升级可学会招式表', poke.levellist),
          _buildTableListView('(可反复使用的)招式学习器', poke.tmlist),
          _buildTableListView('(一次性使用的)招式记录', poke.trlist),
          _buildTableListView('蛋招式', poke.breedlist),
          _buildTableListView('教授招式', poke.tutorlist),
        ],
      ),
    );
  }

  Widget _buildTableListView(String text, List<MoveModel> moves) {
    return CardInCardWidget(
      text: text,
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(39.0),
              1: FixedColumnWidth(75.0),
              2: FixedColumnWidth(48.0),
              3: FixedColumnWidth(40.0),
              4: FixedColumnWidth(39.0),
              5: FixedColumnWidth(39.0),
              6: FixedColumnWidth(39.0),
            },
            border: TableBorder.all(
              color: Colors.grey[200],
              width: 2.0,
              style: BorderStyle.solid,
            ),
            children: new List<TableRow>.from(
              moves.map((move) {
                return TableRow(
                  children: _buildTableRowView(
                      move,
                      move.name == '招式'
                          ? COLORS.COLOR_MAP[poke.types[0]]
                          : Colors.white,
                      move.name == '招式' ? Colors.white : Colors.black),
                );
              }),
            ).toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTableRowView(MoveModel move,
      [Color cellColor = Colors.white, Color textColor = Colors.black]) {
    return [
      _buildTableCellView(
          '${move.sourceText.contains('-') ? '亲代' : move.sourceText}',
          cellColor,
          textColor),
      _buildTableCellView(sprintf('%5s', [move.name]), cellColor, textColor),
      _buildTableCellView(sprintf('%3s', [move.type]), cellColor, textColor),
      _buildTableCellView(
          sprintf('%3s', [move.damagecategory]), cellColor, textColor),
      _buildTableCellView('${move.power}', cellColor, textColor),
      _buildTableCellView('${move.accuracy}', cellColor, textColor),
      _buildTableCellView('${move.basepp}', cellColor, textColor),
    ];
  }

  Widget _buildTableCellView(String text,
      [Color cellColor = Colors.white, Color textColor = Colors.black]) {
    return Container(
      color: cellColor,
      padding: const EdgeInsets.all(2.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
