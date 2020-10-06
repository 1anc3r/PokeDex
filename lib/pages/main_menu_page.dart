import 'package:flutter/material.dart';
import 'package:pokemon/consts/urls.dart';
import 'package:pokemon/widgets/move_list.widget.dart';
import 'package:pokemon/widgets/poke_ball_widget.dart';
import 'package:pokemon/widgets/poke_list_widget.dart';

class MainMenuPage extends StatefulWidget {
  MainMenuPage({Key key}) : super(key: key);

  @override
  MainMenuPageState createState() => MainMenuPageState();
}

class MainMenuPageState extends State<MainMenuPage> {
  MainMenuPageState();

  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return _buildMainMenuView();
  }

  Widget _buildMainMenuView() {
    return Column(
      children: [
        Container(
          height: 72,
          color: Colors.white,
          padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 1,
              child: _buildNaviView(0, '图鉴'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(1, '属性'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(2, '蛋群'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(3, '分布'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(4, '道具'),
            ),
          ]),
        ),
        Container(
          height: 72,
          color: Colors.white,
          padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 1,
              child: _buildNaviView(5, '招式'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(6, '特性'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(7, '个性'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(8, '性格'),
            ),
            Expanded(
              flex: 1,
              child: _buildNaviView(9, '计算'),
            ),
          ]),
        ),
        Divider(
          height: 1,
          color: Colors.grey[240],
        ),
        Expanded(
          child: _getTabContent(tab),
        ),
      ],
    );
  }

  Widget _buildNaviView(int indes, String text) {
    return GestureDetector(
        onTap: () {
          setState(() {
            tab = indes;
          });
        },
        child: Column(
          children: [
            // Container(
            //   height: 36,
            //   width: 36,
            //   child: PokeBallWidget(),
            // ),
            Image.asset(
              URLS.MENU_ICON_MAP[text],
              width: 36,
              height: 36,
            ),
            Text(text),
          ],
        ));
  }

  Widget _getTabContent(int tab) {
    Widget w;
    switch (tab) {
      case 0:
        w = PokeListWidget();
        break;
      case 5:
        w = MoveListWidget();
        break;
      default:
        w = PokeListWidget();
    }
    return w;
  }
}
