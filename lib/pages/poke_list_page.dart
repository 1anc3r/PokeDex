import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/modules/poke_module.dart';
import 'package:pokemon/pages/poke_item_page.dart';
import 'package:pokemon/utils/constants.dart';

class PokeListPage extends StatefulWidget {
  PokeListPage({Key key}) : super(key: key);

  @override
  PokeListPageState createState() {
    return PokeListPageState();
  }
}

class PokeListPageState extends State<PokeListPage> {
  int tab;
  bool loadCompleted = false;

  @override
  void initState() {
    super.initState();
    PokeModule.fetchList().whenComplete(() => setState(() {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: loadCompleted
          ? _buildExpandListView(context)
          : Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 72.0,
                color: Colors.red,
              ),
            ),
    );
  }

  Widget _buildExpandListView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView.builder(
                itemCount: PokeModule.instance.pokes.keys.length,
                itemBuilder: (context, index) {
                  return _buildListTitleCardView(
                      context, PokeModule.instance.pokes.keys.elementAt(index));
                }),
          ),
        ),
        Expanded(
          flex: 7,
          child: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView.builder(
              itemCount: PokeModule.instance
                  .pokes[PokeModule.instance.pokes.keys.elementAt(tab)].length,
              itemBuilder: (context, index) {
                return _buildListItemCardView(
                    context,
                    PokeModule.instance.pokes[
                        PokeModule.instance.pokes.keys.elementAt(tab)][index]);
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
          if (PokeModule.instance.pokes.keys.length > 0) {
            tab = PokeModule.instance.pokes.keys.toList().indexOf(key);
          }
        });
      },
      child: Container(
        color: tab == PokeModule.instance.pokes.keys.toList().indexOf(key)
            ? Colors.red
            : Colors.white,
        child: new Padding(
          padding: const EdgeInsets.only(top: 5.2, bottom: 5.2),
          child: Column(children: [
            Container(
              width: 36,
              height: 36,
              child: Image.asset(Constants.POKE_PIKACHU_MAP[key]),
            ),
            Text(
              key.replaceAll(' ', '\n'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color:
                    tab == PokeModule.instance.pokes.keys.toList().indexOf(key)
                        ? Colors.white
                        : Colors.black,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildListItemCardView(BuildContext context, PokeModel model) {
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
                          Row(
                            children: [
                              Text(
                                model.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                              _buildItemNumberCardView('${model.ndex}'),
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
            color: Colors.white,
            fontWeight: FontWeight.normal,
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

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          showLeading: false,
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );
    }
    return null;
  }
}
