import 'package:flutter/material.dart';
import 'package:flutterapp/douban/Network/tw_douban_network.dart';
import 'package:flutterapp/douban/home/tw_douban_home_list_cell.dart';
import 'package:flutterapp/douban/home/tw_douban_home_network.dart';
import 'package:flutterapp/douban/model/tw_douban_home_model.dart';

///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-25 22:26

class TWDoubanHomePageContent extends StatefulWidget {
  const TWDoubanHomePageContent({Key key}) : super(key: key);

  @override
  _TWDoubanHomePageContentState createState() => _TWDoubanHomePageContentState();
}

class _TWDoubanHomePageContentState extends State<TWDoubanHomePageContent> {


  final List<TWDoubanHomeMovieItem> movies = [];

  @override
  Widget build(BuildContext context) {
    return createList();
  }

  @override
  void initState() {
    super.initState();
    TWDoubanHomeNetwork.requestMovieList(0).then((value) {
      setState(() {
        movies.addAll(value);
      });
    });
  }

  Widget createList() {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return TWDoubanHomeListCell(movies[index]);
        },

    );
  }




}
