import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pokemon/models/pokemon_model.dart';
import 'package:pokemon/modules/pokemon_module.dart';
import 'package:pokemon/pages/pokemon_item_page.dart';

class PokemonListPage extends StatefulWidget {
  PokemonListPage({Key key}) : super(key: key);

  @override
  PokemonListPageState createState() {
    return PokemonListPageState();
  }
}

class PokemonListPageState extends State<PokemonListPage> {
  @override
  void initState() {
    super.initState();
    PokemonModule.fetchList().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PokemonModule.instance.pokemons.length > 0
          ? new ListView.builder(
              itemCount: PokemonModule.instance.pokemons.length,
              itemBuilder: (context, index) {
                return _buildListItemCard(
                    context, PokemonModule.instance.pokemons[index]);
              })
          : Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 72.0,
                color: Colors.red,
              ),
            ),
    );
  }

  _buildListItemCard(BuildContext context, PokemonModel model) {
    return new GestureDetector(
      onTap: () => _navigateToItem(context, model.name),
      child: new Card(
        margin:
            const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  model.lqImg,
                  width: 50.0,
                  height: 50.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${model.jname} ${model.enname}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ]),
                  ),
                ),
                DropdownButton(
                  hint: Text(
                    '#${model.ndex}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  icon: Icon(
                    Icons.navigate_next,
                    size: 22.0,
                    color: Color(0xffacacac),
                  ),
                  underline: Container(color: Colors.white),
                ),
              ]),
        ),
      ),
    );
  }

  _navigateToItem(BuildContext context, String name) {
    Navigator.of(context).push(MaterialPageRoute(builder: (content) {
      return PokemonItemPage(pokemonName: name);
    }));
  }
}
