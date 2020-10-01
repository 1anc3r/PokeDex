import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon_model.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/widgets/card_in_card_widget.dart';
import 'package:pokemon/widgets/line_process_widget.dart';
import 'package:sprintf/sprintf.dart';

class PokemonInfoWidget extends StatefulWidget {
  final PokemonModel pokemon;

  PokemonInfoWidget({Key key, @required this.pokemon}) : super(key: key);

  @override
  PokemonInfoState createState() {
    return PokemonInfoState(pokemon);
  }
}

class PokemonInfoState extends State<PokemonInfoWidget>
    with SingleTickerProviderStateMixin {
  final PokemonModel pokemon;

  PokemonInfoState(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(children: [
          Row(children: [
            // 图片和名字
            _buildItemHeadIcon(),
            // 种族值
            _buildItemSpeciesStrength(),
          ]),
          Row(children: [
            // 属性
            _buildItemTypes(),
            Expanded(
              //分类
              child: _buildItemSpecies(),
            ),
          ]),
          // 特性
          _buildItemAbilities(),
          // 蛋群
          _buildItemEgggroups(),
          // 100级时经验值
          _buildItemLv100exp(),
          Row(children: [
            Expanded(
              // 身高
              child: _buildItemHeight(),
              flex: 1,
            ),
            Expanded(
              // 体重
              child: _buildItemWeight(),
              flex: 1,
            ),
          ]),
          // 性别比例
          _buildItemGenderCode(),
          Row(children: [
            Expanded(
              // 捕获率
              child: _buildItemCatchRate(),
              flex: 1,
            ),
            Expanded(
              //孵化周期
              child: _buildItemEggcycles(),
              flex: 1,
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _buildItemHeadIcon() {
    return Expanded(
      flex: 1,
      child: Column(children: [
        pokemon.hqImg != null
            ? Image.network(
                pokemon.hqImg,
                width: 100,
                height: 100,
              )
            : Text(''),
        Text(
          pokemon.name,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Text(
          '${pokemon.jname} ${pokemon.enname}',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ]),
    );
  }

  Widget _buildItemSpeciesStrength() {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        LineProcessWidget(
            keyword: '生命',
            valueword: pokemon.speciesStrengths['生命'],
            process: pokemon.speciesStrengths['生命'] / 255,
            color: Constants.POKEMON_COLOR_MAP['生命']),
        LineProcessWidget(
            keyword: '攻击',
            valueword: pokemon.speciesStrengths['攻击'],
            process: pokemon.speciesStrengths['攻击'] / 255,
            color: Constants.POKEMON_COLOR_MAP['攻击']),
        LineProcessWidget(
            keyword: '防御',
            valueword: pokemon.speciesStrengths['防御'],
            process: pokemon.speciesStrengths['防御'] / 255,
            color: Constants.POKEMON_COLOR_MAP['防御']),
        LineProcessWidget(
            keyword: '特攻',
            valueword: pokemon.speciesStrengths['特攻'],
            process: pokemon.speciesStrengths['特攻'] / 255,
            color: Constants.POKEMON_COLOR_MAP['特攻']),
        LineProcessWidget(
            keyword: '特防',
            valueword: pokemon.speciesStrengths['特防'],
            process: pokemon.speciesStrengths['特防'] / 255,
            color: Constants.POKEMON_COLOR_MAP['特防']),
        LineProcessWidget(
            keyword: '速度',
            valueword: pokemon.speciesStrengths['速度'],
            process: pokemon.speciesStrengths['速度'] / 255,
            color: Constants.POKEMON_COLOR_MAP['速度']),
        LineProcessWidget(
            keyword: '总和',
            valueword: (pokemon.speciesStrengths['生命'] +
                pokemon.speciesStrengths['攻击'] +
                pokemon.speciesStrengths['防御'] +
                pokemon.speciesStrengths['特攻'] +
                pokemon.speciesStrengths['特防'] +
                pokemon.speciesStrengths['速度']),
            process: 1,
            color: Colors.white),
      ]),
    );
  }

  Widget _buildItemTypes() {
    return CardInCardWidget(
      text: '属性',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          children: new List<Widget>.from(
            pokemon.types.map((type) {
              return _buildTypeCard(type);
            }),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildItemSpecies() {
    return CardInCardWidget(
        text: '分类',
        color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
        child: Card(
          color: Colors.white,
          elevation: 0,
          child: Text('${pokemon.species}宝可梦'),
        ));
  }

  Widget _buildItemAbilities() {
    return CardInCardWidget(
      text: '特性',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          children: new List<Widget>.from(
            pokemon.abilities.map((ability) {
              return Card(
                color: Colors.white,
                elevation: 0,
                child: Text(
                    '${ability}${ability == pokemon.abilities[pokemon.abilities.length - 1] ? '' : '  和'}'),
              );
            }),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildItemEgggroups() {
    return CardInCardWidget(
      text: '蛋群',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          children: new List<Widget>.from(
            pokemon.egggroups.map((egggroup) {
              return Card(
                color: Colors.white,
                elevation: 0,
                child: Text(
                    '${egggroup}${egggroup == pokemon.egggroups[pokemon.egggroups.length - 1] ? '' : '  和'}'),
              );
            }),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildItemLv100exp() {
    return CardInCardWidget(
      text: '100级时经验值',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${pokemon.lv100exp}'),
      ),
    );
  }

  Widget _buildItemHeight() {
    return CardInCardWidget(
      text: '身高',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${pokemon.height}m'),
      ),
    );
  }

  Widget _buildItemWeight() {
    return CardInCardWidget(
      text: '体重',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${pokemon.weight}m'),
      ),
    );
  }

  Widget _buildItemGenderCode() {
    return CardInCardWidget(
      text: '性别比例',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Row(children: [
          Text(
              '雄性 ${Constants.POKEMON_GENDER_CODE_MAP[pokemon.gendercode] * 100}%  '),
          Container(
            height: 12,
            width: 100,
            child: LinearProgressIndicator(
              backgroundColor: Constants.POKEMON_COLOR_MAP['雌性'],
              valueColor:
                  AlwaysStoppedAnimation(Constants.POKEMON_COLOR_MAP['雄性']),
              value: Constants.POKEMON_GENDER_CODE_MAP[pokemon.gendercode],
            ),
          ),
          Text(
              '  雌性 ${(1 - Constants.POKEMON_GENDER_CODE_MAP[pokemon.gendercode]) * 100}%  '),
        ]),
      ),
    );
  }

  Widget _buildItemCatchRate() {
    return CardInCardWidget(
      text: '捕获率',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text(sprintf('%2.2f%', [1 / 3 * pokemon.catchrate / 255 * 100])),
      ),
    );
  }

  Widget _buildItemEggcycles() {
    return CardInCardWidget(
      text: '孵化周期',
      color: Constants.POKEMON_COLOR_MAP[pokemon.types[0]],
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Text('${pokemon.eggcycles * 256}步'),
      ),
    );
  }

  Widget _buildTypeCard(String type) {
    return Card(
      color: Colors.grey,
      child: Row(
        children: [
          ClipPath(
            child: Container(
              color: Constants.POKEMON_COLOR_MAP[type],
              child: Image.asset(
                '${Constants.POKEMON_TYPE_ICON_PRE_URL}${type}.png',
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
