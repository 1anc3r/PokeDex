import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pokemon/behavior/over_scroll_behavior.dart';
import 'package:pokemon/consts/urls.dart';
import 'package:pokemon/models/move_model.dart';
import 'package:pokemon/modules/move_module.dart';
import 'package:pokemon/pages/poke_item_page.dart';

class MoveListWidget extends StatefulWidget {
  MoveListWidget({Key key}) : super(key: key);

  @override
  MoveListWidgetState createState() {
    return MoveListWidgetState();
  }
}

class MoveListWidgetState extends State<MoveListWidget> {
  int tab;
  bool loadCompleted = false;

  @override
  void initState() {
    super.initState();
    MoveModule.fetchList().whenComplete(() => setState(() {
          tab = 0;
          loadCompleted = true;
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loadCompleted
        ? _buildListView(context)
        : Center(
            child: Loading(
              indicator: BallPulseIndicator(),
              size: 72.0,
              color: Colors.red,
            ),
          );
  }

  Widget _buildListView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView.builder(
                itemCount: MoveModule.instance.moves.keys.length,
                itemBuilder: (context, index) {
                  return _buildListTitleCardView(
                      context, MoveModule.instance.moves.keys.elementAt(index));
                }),
          ),
        ),
        VerticalDivider(
          width: 1,
          color: Colors.grey[240],
        ),
        Expanded(
          flex: 7,
          child: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView.builder(
              itemCount: MoveModule.instance
                  .moves[MoveModule.instance.moves.keys.elementAt(tab)].length,
              itemBuilder: (context, index) {
                return _buildListItemCardView(
                    context,
                    MoveModule.instance.moves[
                        MoveModule.instance.moves.keys.elementAt(tab)][index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListTitleCardView(BuildContext context, String key) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (MoveModule.instance.moves.keys.length > 0) {
            tab = MoveModule.instance.moves.keys.toList().indexOf(key);
          }
        });
      },
      child: Container(
        color: tab == MoveModule.instance.moves.keys.toList().indexOf(key)
            ? Colors.red
            : Colors.white,
        child: new Padding(
          padding: const EdgeInsets.only(top: 5.2, bottom: 5.2),
          child: Column(children: [
            Container(
              width: 36,
              height: 36,
              child: Image.asset(URLS.POKE_PIKACHU_MAP[key]),
            ),
            Text(
              key.replaceAll(' ', '\n'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color:
                    tab == MoveModule.instance.moves.keys.toList().indexOf(key)
                        ? Colors.white
                        : Colors.black,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildListItemCardView(BuildContext context, MoveModel model) {
    return GestureDetector(
      onTap: () => _navigateToItem(context, model.name),
      child: Card(
        margin:
            const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.network(
                //   model.lqImg,
                //   width: 50.0,
                //   height: 50.0,
                // ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildItemNumberCardView('${model.n}'),
                              Text(
                                model.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
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
              ]),
        ),
      ),
    );
  }

  Widget _buildItemNumberCardView(String number) {
    return Card(
      color: Colors.black87,
      child: new Padding(
        padding:
            new EdgeInsets.only(top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
        child: Text(
          'No.$number',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
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
