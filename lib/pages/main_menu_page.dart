import 'package:flutter/material.dart';
import 'package:pokemon/widgets/poke_ball_widget.dart';

class MainMenuPage extends StatefulWidget {
  Widget child;

  MainMenuPage({Key key, @required this.child}) : super(key: key);

  @override
  MainMenuPageState createState() => MainMenuPageState(child);
}

class MainMenuPageState extends State<MainMenuPage> {
  Widget child;

  MainMenuPageState(this.child);

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: _buildNaviView('宝可梦'),
              ),
              Expanded(
                flex: 1,
                child: _buildNaviView('招式'),
              ),
              Expanded(
                flex: 1,
                child: _buildNaviView('特性'),
              ),
              Expanded(
                flex: 1,
                child: _buildNaviView('道具'),
              ),
              Expanded(
                flex: 1,
                child: _buildNaviView('分布'),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey[240],
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }

  Widget _buildNaviView(String text) {
    return Column(
      children: [
        Container(
          height: 36,
          width: 36,
          child: PokeBallWidget(),
        ),
        Text(text),
      ],
    );
  }
}
