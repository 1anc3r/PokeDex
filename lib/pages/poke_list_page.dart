import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/modules/poke_module.dart';
import 'package:pokemon/pages/poke_item_page.dart';

class PokeListPage extends StatefulWidget {
  PokeListPage({Key key}) : super(key: key);

  @override
  PokeListPageState createState() {
    return PokeListPageState();
  }
}

class PokeListPageState extends State<PokeListPage> {
  @override
  void initState() {
    super.initState();
    PokeModule.fetchList().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PokeModule.instance.pokes.length > 0
          ? new ListView.builder(
              itemCount: PokeModule.instance.pokes.length,
              itemBuilder: (context, index) {
                return _buildListItemCard(
                    context, PokeModule.instance.pokes[index]);
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

  _buildListItemCard(BuildContext context, PokeModel model) {
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
      return PokeItemPage(pokeName: name);
    }));
  }
}
