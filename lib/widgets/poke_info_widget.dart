import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/widgets/card_in_card_widget.dart';
import 'package:pokemon/widgets/line_process_widget.dart';
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
            name: '生命',
            value: poke.speciesStrengths['生命'],
            process: poke.speciesStrengths['生命'] / 255,
            color: Constants.POKE_COLOR_MAP['生命']),
        LineProcessWidget(
            name: '攻击',
            value: poke.speciesStrengths['攻击'],
            process: poke.speciesStrengths['攻击'] / 255,
            color: Constants.POKE_COLOR_MAP['攻击']),
        LineProcessWidget(
            name: '防御',
            value: poke.speciesStrengths['防御'],
            process: poke.speciesStrengths['防御'] / 255,
            color: Constants.POKE_COLOR_MAP['防御']),
        LineProcessWidget(
            name: '特攻',
            value: poke.speciesStrengths['特攻'],
            process: poke.speciesStrengths['特攻'] / 255,
            color: Constants.POKE_COLOR_MAP['特攻']),
        LineProcessWidget(
            name: '特防',
            value: poke.speciesStrengths['特防'],
            process: poke.speciesStrengths['特防'] / 255,
            color: Constants.POKE_COLOR_MAP['特防']),
        LineProcessWidget(
            name: '速度',
            value: poke.speciesStrengths['速度'],
            process: poke.speciesStrengths['速度'] / 255,
            color: Constants.POKE_COLOR_MAP['速度']),
        LineProcessWidget(
            name: '总和',
            value: (poke.speciesStrengths['生命'] +
                poke.speciesStrengths['攻击'] +
                poke.speciesStrengths['防御'] +
                poke.speciesStrengths['特攻'] +
                poke.speciesStrengths['特防'] +
                poke.speciesStrengths['速度']),
            process: 1,
            color: Colors.white),
      ]),
    );
  }

  Widget _buildItemTypesView() {
    return CardInCardWidget(
      text: '属性',
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
        color: Constants.POKE_COLOR_MAP[poke.types[0]],
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Text('${poke.species}宝可梦'),
        ));
  }

  Widget _buildItemAbilitiesView() {
    return CardInCardWidget(
      text: '特性',
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Row(children: [
          Text(
              '雄性 ${Constants.POKE_GENDER_CODE_MAP[poke.gendercode] * 100}%  '),
          Container(
            height: 12,
            width: 100,
            child: LinearProgressIndicator(
              backgroundColor: Constants.POKE_COLOR_MAP['雌性'],
              valueColor:
                  AlwaysStoppedAnimation(Constants.POKE_COLOR_MAP['雄性']),
              value: Constants.POKE_GENDER_CODE_MAP[poke.gendercode],
            ),
          ),
          Text(
              '  雌性 ${(1 - Constants.POKE_GENDER_CODE_MAP[poke.gendercode]) * 100}%  '),
        ]),
      ),
    );
  }

  Widget _buildItemCatchRateView() {
    return CardInCardWidget(
      text: '捕获率',
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
      color: Constants.POKE_COLOR_MAP[poke.types[0]],
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
              color: Constants.POKE_COLOR_MAP[type],
              child: Image.asset(
                '${Constants.POKE_TYPE_ICON_PRE_URL}${type}.png',
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
