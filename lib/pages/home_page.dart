import 'package:flutter/material.dart';
import 'package:pokemon/pages/blank_page.dart';
import 'package:pokemon/widgets/poke_ball_widget.dart';
import 'package:pokemon/widgets/poke_list_widget.dart';
import 'package:pokemon/widgets/search_text_field_bar.dart';

import 'main_menu_page.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List _titles = ['图鉴', '招式', '道具'];
  List _pages = [
    MainMenuPage(
      child: PokeListWidget(),
    ),
    BlankPage(),
    BlankPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text(_titles[_selectedIndex]),
        actions: <Widget>[
          SearchTextFieldBar(
            heroTag: "SearchBar",
            label: '搜索${_titles[_selectedIndex]}',
            hint: '${_titles[_selectedIndex]}名字或编号',
          ),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.usb),
              onPressed: () => {_onItemTapped(1)},
            ),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(Icons.laptop_mac),
              onPressed: () => {_onItemTapped(2)},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //悬浮按钮
        child: PokeBallWidget(),
        backgroundColor: Colors.white,
        onPressed: () => {_onItemTapped(0)},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch() {}
}
