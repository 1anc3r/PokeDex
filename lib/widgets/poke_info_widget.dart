import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/consts/colors.dart';
import 'package:pokemon/consts/numbers.dart';
import 'package:pokemon/consts/strings.dart';
import 'package:pokemon/consts/urls.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/views/card_in_card_widget.dart';
import 'package:pokemon/views/line_process_widget.dart';
import 'package:sprintf/sprintf.dart';

class PokeInfoWidget extends StatefulWidget {
  final PokeModel poke;

  PokeInfoWidget({Key key, @required this.poke}) : super(key: key);

  @override
  PokeInfoState createState() {
    return PokeInfoState(poke);
  }
}

class PokeInfoState extends State<PokeInfoWidget>
    with SingleTickerProviderStateMixin {
  final PokeModel poke;

  PokeInfoState(this.poke);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(6.0),
      child: Column(children: [
        Row(children: [
          // 图片和名字
          _buildItemImageView(),
          // 种族值
          _buildItemSpeciesStrengthView(),
        ]),
        Row(children: [
          // 属性
          _buildItemTypesView(),
          Expanded(
            //分类
            child: _buildItemSpeciesView(),
          ),
        ]),
        // 特性
        _buildItemAbilitiesView(),
        // 蛋群
        _buildItemEgggroupsView(),
        // 100级时经验值
        _buildItemLv100expView(),
        Row(children: [
          Expanded(
            flex: 1,
            // 身高
            child: _buildItemHeightView(),
          ),
          Expanded(
            flex: 1,
            // 体重
            child: _buildItemWeightView(),
          ),
        ]),
        // 性别比例
        _buildItemGenderView(),
        Row(children: [
          Expanded(
            flex: 1,
            // 捕获率
            child: _buildItemCatchRateView(),
          ),
          Expanded(
            flex: 1,
            //孵化周期
            child: _buildItemEggcyclesView(),
          ),
        ]),
      ]),
    );
  }

  Widget _buildItemImageView() {
    return Expanded(
      flex: 1,
      child: Column(children: [
        poke.hqImg != null
            ? Image.network(
                poke.hqImg,
                width: 100,
                height: 100,
              )
            : Text(''),
        Text(
          poke.name,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Text(
          '${poke.jname} ${poke.enname}',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ]),
    );
  }

  Widget _buildItemSpeciesStrengthView() {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        LineProcessWidget(
            name: STRINGS.HP,
            value: poke.speciesStrengths[STRINGS.HP],
            process: poke.speciesStrengths[STRINGS.HP] / 255,
            color: COLORS.COLOR_MAP[STRINGS.HP]),
        LineProcessWidget(
            name: STRINGS.ATK,
            value: poke.speciesStrengths[STRINGS.ATK],
            process: poke.speciesStrengths[STRINGS.ATK] / 255,
            color: COLORS.COLOR_MAP[STRINGS.ATK]),
        LineProcessWidget(
            name: STRINGS.DEF,
            value: poke.speciesStrengths[STRINGS.DEF],
            process: poke.speciesStrengths[STRINGS.DEF] / 255,
            color: COLORS.COLOR_MAP[STRINGS.DEF]),
        LineProcessWidget(
            name: STRINGS.SAT,
            value: poke.speciesStrengths[STRINGS.SAT],
            process: poke.speciesStrengths[STRINGS.SAT] / 255,
            color: COLORS.COLOR_MAP[STRINGS.SAT]),
        LineProcessWidget(
            name: STRINGS.SDE,
            value: poke.speciesStrengths[STRINGS.SDE],
            process: poke.speciesStrengths[STRINGS.SDE] / 255,
            color: COLORS.COLOR_MAP[STRINGS.SDE]),
        LineProcessWidget(
            name: STRINGS.SPD,
            value: poke.speciesStrengths[STRINGS.SPD],
            process: poke.speciesStrengths[STRINGS.SPD] / 255,
            color: COLORS.COLOR_MAP[STRINGS.SPD]),
        LineProcessWidget(
            name: STRINGS.TOTAL,
            value: (poke.speciesStrengths[STRINGS.HP] +
                poke.speciesStrengths[STRINGS.ATK] +
                poke.speciesStrengths[STRINGS.DEF] +
                poke.speciesStrengths[STRINGS.SAT] +
                poke.speciesStrengths[STRINGS.SDE] +
                poke.speciesStrengths[STRINGS.SPD]),
            process: 1,
            color: Colors.white),
      ]),
    );
  }

  Widget _buildItemTypesView() {
    return CardInCardWidget(
      text: '属性',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          children: new List<Widget>.from(
            poke.types.map((type) {
              return _buildTypeCardView(type);
            }),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildItemSpeciesView() {
    return CardInCardWidget(
        text: '分类',
        color: COLORS.COLOR_MAP[poke.types[0]],
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Text('${poke.species}宝可梦'),
        ));
  }

  Widget _buildItemAbilitiesView() {
    return CardInCardWidget(
      text: '特性',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          children: new List<Widget>.from(
            poke.abilities.map((ability) {
              return Card(
                color: Colors.white,
                elevation: 0,
                child: Text(
                    '${ability}${ability == poke.abilities[poke.abilities.length - 1] ? '' : '  和'}'),
              );
            }),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildItemEgggroupsView() {
    return CardInCardWidget(
      text: '蛋群',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          children: new List<Widget>.from(
            poke.egggroups.map((egggroup) {
              return Card(
                color: Colors.white,
                elevation: 0,
                child: Text(
                    '${egggroup}${egggroup == poke.egggroups[poke.egggroups.length - 1] ? '' : '  和'}'),
              );
            }),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildItemLv100expView() {
    return CardInCardWidget(
      text: '100级时经验值',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${poke.lv100exp}'),
      ),
    );
  }

  Widget _buildItemHeightView() {
    return CardInCardWidget(
      text: '身高',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${poke.height}m'),
      ),
    );
  }

  Widget _buildItemWeightView() {
    return CardInCardWidget(
      text: '体重',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${poke.weight}kg'),
      ),
    );
  }

  Widget _buildItemGenderView() {
    return CardInCardWidget(
      text: '性别比例',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Row(children: [
          Text('雄性 ${NUMBERS.POKE_GENDER_CODE_MAP[poke.gendercode] * 100}%  '),
          Container(
            height: 12,
            width: 100,
            child: LinearProgressIndicator(
              backgroundColor: COLORS.COLOR_MAP['雌性'],
              valueColor: AlwaysStoppedAnimation(COLORS.COLOR_MAP['雄性']),
              value: NUMBERS.POKE_GENDER_CODE_MAP[poke.gendercode],
            ),
          ),
          Text(
              '  雌性 ${(1 - NUMBERS.POKE_GENDER_CODE_MAP[poke.gendercode]) * 100}%  '),
        ]),
      ),
    );
  }

  Widget _buildItemCatchRateView() {
    return CardInCardWidget(
      text: '捕获率',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text(sprintf('%2.2f%', [1 / 3 * poke.catchrate / 255 * 100])),
      ),
    );
  }

  Widget _buildItemEggcyclesView() {
    return CardInCardWidget(
      text: '孵化周期',
      color: COLORS.COLOR_MAP[poke.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${poke.eggcycles * 256}步'),
      ),
    );
  }

  Widget _buildTypeCardView(String type) {
    return Card(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipPath(
            child: Container(
              color: COLORS.COLOR_MAP[type],
              child: Image.asset(
                '${URLS.POKE_TYPE_ICON_PRE_URL}${type}.png',
              ),
            ),
            clipper: TypeIconClipper(),
          ),
          Text(
            '    $type    ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class TypeIconClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
