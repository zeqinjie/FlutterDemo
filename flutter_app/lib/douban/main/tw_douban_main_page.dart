import 'package:flutter/material.dart';
import 'package:flutterapp/douban/model/tw_douban_cofigure_item.dart';

class TWDoubanMainPage extends StatefulWidget {
  const TWDoubanMainPage({Key key}) : super(key: key);

  @override
  _TWDoubanMainPageState createState() => _TWDoubanMainPageState();
}

class _TWDoubanMainPageState extends State<TWDoubanMainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: doubanPages,
      ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: doubanBottomBarItems,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        )
    );
  }
}
