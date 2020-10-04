import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget {
  BlankPage({Key key}) : super(key: key);

  @override
  BlankPageState createState() {
    return BlankPageState();
  }
}

class BlankPageState extends State<BlankPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("BLANK"),
    );
  }
}
