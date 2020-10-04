import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/modules/poke_module.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/widgets/poke_info_widget.dart';
import 'package:pokemon/widgets/poke_move_widget.dart';
import 'package:pokemon/widgets/poke_stat_widget.dart';

class PokeItemPage extends StatefulWidget {
  final String pokeName;

  PokeItemPage({Key key, @required this.pokeName}) : super(key: key);

  @override
  PokeItemPageState createState() {
    return PokeItemPageState(pokeName);
  }
}

class PokeItemPageState extends State<PokeItemPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabBarTexts = ["基础", "能力", "招式", "分布"];
  List tabBarViews = <Widget>[];

  final String pokeName;
  PokeModel poke;

  PokeItemPageState(this.pokeName);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabBarTexts.length, vsync: this);
    PokeModule.fetchItem(pokeName).then((model) => {poke = model}).then(
        (model) => {
              PokeModule.fetchItemHQImg(poke)
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
      poke != null
          ? PokeInfoWidget(poke: poke)
          : Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 72.0,
                color: Colors.red,
              ),
            ),
      poke != null
          ? PokeStatWidget(poke: poke)
          : Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 72.0,
                color: Colors.red,
              ),
            ),
      poke != null
          ? PokeMoveWidget(poke: poke)
          : Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 72.0,
                color: Colors.red,
              ),
            ),
      _buildItemMoveView(),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Constants.POKE_COLOR_MAP[poke != null ? poke.types[0] : '一般'],
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

  _buildItemMoveView() {
    return poke != null
        ? Column(children: [
            Image.network(
              poke.lqImg,
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
