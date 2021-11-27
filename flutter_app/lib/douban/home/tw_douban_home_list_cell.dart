import 'package:flutter/material.dart';
import 'package:flutterapp/douban/model/tw_douban_home_model.dart';
import 'package:flutterapp/douban/view/tw_douban_dashed_line.dart';
import 'package:flutterapp/douban/view/tw_douban_star_rating.dart';

///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-27 14:19 


class TWDoubanHomeListCell extends StatelessWidget {

  final TWDoubanHomeMovieItem movie;

  TWDoubanHomeListCell(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 8,
            color: Colors.grey
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          SizedBox(height: 8,),
          buildContent(),
          SizedBox(height: 8,),
          buildFooter(),
        ],
      ),
    );
  }

  // 1.头部
  Widget buildHeader() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 238, 205, 144),
        borderRadius:  BorderRadius.all(Radius.circular(3))
      ),
      child: Text("No.${this.movie.rank}"),
    );
  }

  // 2. 内容布局
  // Widget buildContent() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       buildContentImage(),
  //       buildContentInfo(),
  //       buildContentLine(),
  //       buildContentWish()
  //     ],
  //   );
  // }

  // 2.内容的布局
  Widget buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildContentImage(),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                buildContentInfo(),
                SizedBox(
                  width: 8,
                ),
                buildContentLine(),
                SizedBox(
                  width: 8,
                ),
                buildContentWish()
              ],
            ),
          ),
        )
      ],
    );
  }

  // 2.1 图片
  Widget buildContentImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(movie.imageURL,height: 150,),
    );
  }

  // 2.2 内容 Expanded 包裹 最大撑开
  Widget buildContentInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContentInfoTitle(),
          buildContentInfoRate(),
          buildContentInfoDesc(),
        ],
      ),
    );
  }

  // 2.2.1 内容 - 标题
  Widget buildContentInfoTitle() {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.pink,
              size: 40,
            ),
            baseline: TextBaseline.ideographic,
            alignment: PlaceholderAlignment.middle
          ),
          ...movie.title.runes.map((rune) {
            return WidgetSpan(
                child: Text(
                  String.fromCharCode(rune),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                alignment: PlaceholderAlignment.middle
            );
          }).toList(),
          WidgetSpan(
              child: Text("(${movie.playDate})"),
              style: TextStyle(fontSize: 18, color: Colors.grey),
              alignment: PlaceholderAlignment.bottom
          )
        ]
      )
    );
  }

  // 2.2.2 内容 - 评分
  Widget buildContentInfoRate() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: Row(
        children: [
          TWDoubanStarRating(
            rating: movie.rating,
            size: 20,
          ),
          SizedBox(width: 6,),
          Text(
            "${movie.rating}",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  // 2.2.3 内容 - 说明
  Widget buildContentInfoDesc() {
    final genresString = movie.genres.join(" ");
    final directorString = movie.director.name;
    List<Actor> casts = movie.casts;
    final actorString = movie.casts.map((item) => item.name).join(" ");
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Text(
        "$genresString / $directorString / $actorString",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  // 2.3 内容的虚线
  Widget buildContentLine() {
    return Container(
     height: 100,
      child: TWDoubanDashedLine(
        axis: Axis.vertical,
        dashedWidth: .4,
        dashedHeight: 6,
        count: 10,
        color: Colors.pink,
      ),
    );
  }

  // 2.4 内容的想看
  Widget buildContentWish() {
    return Container(
     height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/home/wish.png"),
          Text(
            "想看",
            style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 235, 170, 60)
            ),
          )
        ],
      ),
    );
  }

  // 3.尾部的布局
  Widget buildFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        movie.originalTitle,
        style: TextStyle(fontSize: 20, color: Color(0xff666666)),
      ),
    );
  }

}


