import 'package:flutterapp/douban/Network/tw_douban_network.dart';
import 'package:flutterapp/douban/model/tw_douban_home_model.dart';
///@Description     xxxx
///@author          zhengzeqin
///@create          2021-11-27 11:51 


class TWDoubanHomeConfig {
  static const int movieCount = 20;
}

class TWDoubanHomeNetwork {
  static Future<List<TWDoubanHomeMovieItem>> requestMovieList(int start) async {
    // 1.构建URL /movie/new_movies?apikey=0df993c66c0c636e29ecbb5344252a4a
    final movieURL = "/movie/new_movies?apikey=0df993c66c0c636e29ecbb5344252a4a&count=${TWDoubanHomeConfig.movieCount}";

    // 2.发送网络请求获取结果
    final result = await TWDoubanHttpRequest.request(movieURL);
    final subjects = result["subjects"];

    // 3.将Map转成Model
    List<TWDoubanHomeMovieItem> movies = [];
    for (var sub in subjects) {
      movies.add(TWDoubanHomeMovieItem.fromMap(sub));
    }

    return movies;
  }
}