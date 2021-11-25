import 'package:flutter/material.dart';
import 'package:flutterapp/douban/home/tw_douban_home_page.dart';
import 'package:flutterapp/douban/profile/tw_douban_profile_page.dart';
import 'package:flutterapp/douban/view/tw_douban_bottom_bar_item.dart';

///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-25 22:32 

List<TWDoubanBottomBarItem> doubanBottomBarItems = [
  TWDoubanBottomBarItem("home", "首页"),
  TWDoubanBottomBarItem("subject", "书影音"),
  TWDoubanBottomBarItem("group", "小组"),
  TWDoubanBottomBarItem("mall", "市集"),
  TWDoubanBottomBarItem("profile", "我的"),
];

List<Widget> doubanPages = [
  TWDoubanHomePage(),
  TWDoubanProfilePage(),
  TWDoubanProfilePage(),
  TWDoubanProfilePage(),
  TWDoubanProfilePage(),
];