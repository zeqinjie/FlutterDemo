import 'package:flutter/material.dart';

///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-25 22:34 

class TWDoubanBottomBarItem extends BottomNavigationBarItem {
  TWDoubanBottomBarItem(String iconName, String title)
      : super(
    title: Text(title),
    icon: Image.asset("assets/images/tabbar/$iconName.png", width: 32, gaplessPlayback: true,),
    activeIcon: Image.asset("assets/images/tabbar/${iconName}_active.png", width: 32, gaplessPlayback: true,),
  );
}