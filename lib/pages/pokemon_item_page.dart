import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pokemon/models/pokemon_model.dart';
import 'package:pokemon/modules/pokemon_module.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/widgets/pokemon_ball_widget.dart';
import 'package:pokemon/widgets/pokemon_info_widget.dart';
import 'package:pokemon/widgets/pokemon_stat_widget.dart';

class PokemonItemPage extends StatefulWidget {
  final String pokemonName;

  PokemonItemPage({Key key, @required this.pokemonName}) : super(key: key);

  @override
  PokemonItemPageState createState() {
    return PokemonItemPageState(pokemonName);
  }
}

class PokemonItemPageState extends State<PokemonItemPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabBarTexts = ["基础", "能力", "招式", "介绍"];
  List tabBarViews = <Widget>[];

  final String pokemonName;
  PokemonModel pokemon;

  PokemonItemPageState(this.pokemonName);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabBarTexts.length, vsync: this);
    PokemonModule.fetchItem(pokemonName)
        .then((model) => {pokemon = model})
        .then((model) => {
              PokemonModule.fetchItemHQImg(pokemon)
                  .whenComplete(() => setState(() {}))
            });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabBarViews = <Widget>[
      pokemon != null
          ? PokemonInfoWidget(pokemon: pokemon)
          : Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 72.0,
                color: Colors.red,
              ),
            ),
      pokemon != null
          ? PokemonStatWidget(pokemon: pokemon)
          : Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 72.0,
                color: Colors.red,
              ),
            ),
      PokemonBallWidget(),
      _buildItemMove(),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants
              .POKEMON_COLOR_MAP[pokemon != null ? pokemon.types[0] : '一般'],
          toolbarHeight: kToolbarHeight,
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: tabBarTexts.map((e) => Tab(text: e)).toList(),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(controller: _tabController, children: tabBarViews));
  }

  Widget _buildItemMove() {
    return pokemon != null
        ? Column(children: [
            Image.network(
              pokemon.lqImg,
              width: 50.0,
              height: 50.0,
            ),
          ])
        : Center(
            child: Loading(
              indicator: BallPulseIndicator(),
              size: 72.0,
              color: Colors.red,
            ),
          );
  }
}
