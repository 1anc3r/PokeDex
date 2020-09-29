import 'package:flutter/material.dart';
import 'package:pokemon/pages/pokemon_item_page.dart';
import 'package:pokemon/utils/constant.dart';
import 'package:pokemon/widgets/search_text_field_bar.dart';

import 'item_page.dart';
import 'move_page.dart';
import 'pokemon_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List _titles = ['宝可梦', '招式', '道具'];
  List _pages = [
    PokemonListPage(),
    PokemonItemPage(),
    PokemonItemPage(),
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
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.album), title: Text(_titles[0])),
          BottomNavigationBarItem(
              icon: Icon(Icons.usb), title: Text(_titles[1])),
          BottomNavigationBarItem(
              icon: Icon(Icons.laptop_mac), title: Text(_titles[2])),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch() {}
}
