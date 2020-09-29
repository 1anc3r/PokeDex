import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pokemon/modules/pokemon_module.dart';

class PokemonItemPage extends StatefulWidget {
  PokemonItemPage({Key key}) : super(key: key);

  @override
  _PokemonItemPageState createState() {
    return _PokemonItemPageState();
  }
}

class _PokemonItemPageState extends State<PokemonItemPage> {
  @override
  void initState() {
    super.initState();
    PokemonModule.fetchItem('妙蛙种子').whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: PokemonModule.instance.pokemon != null
            ? Column(
                children: [
                  Image.network(
                    PokemonModule.instance.pokemon.lqImg,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Text(PokemonModule.instance.pokemon.name),
                  Text(PokemonModule.instance.pokemon.jname),
                  Text(PokemonModule.instance.pokemon.enname),
                  Text(PokemonModule.instance.pokemon.color),
                ],
              )
            : Center(
                child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 72.0,
                    color: Colors.red)));
  }
}
