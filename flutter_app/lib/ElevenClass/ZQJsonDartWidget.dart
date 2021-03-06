
import 'package:flutter/material.dart';

import 'dart:convert';


class ZQJsonDartWidget extends StatefulWidget {
  ZQJsonDartWidget({Key key}) : super(key: key);

  @override
  _ZQJsonDartWidgetState createState() {
    return _ZQJsonDartWidgetState();
  }
}

class _ZQJsonDartWidgetState extends State<ZQJsonDartWidget> {
  @override
  void initState() {
    super.initState();
//    covertTo();
    convertClass();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("hello...");
  }

  void covertTo(){
    /// 转List
    //一个JSON格式的用户列表字符串
    String jsonStr='[{"name":"Jack"},{"name":"Rose"}]';
    //将JSON字符串转为Dart对象(此处是List)
    List items=json.decode(jsonStr);
    //输出第一个用户的姓名
    print(items[0]["name"]);

    /// 转Map
    /*
    * json.decode()仅返回一个Map<String, dynamic>，这意味着直到运行时我们才知道值的类型。
    * 通过这种方法，我们失去了大部分静态类型语言特性：类型安全、自动补全和最重要的编译时异常。这样一来，我们的代码可能会变得非常容易出错
    * */
    jsonStr='{"name": "John Smith","email": "john@example.com"}';
    Map<String, dynamic> user = json.decode(jsonStr);
    print('Howdy, ${user['name']}!');
    print('We sent the verification link to ${user['email']}.');
  }

  /*
  * 通过转对象
  * */
  void convertClass(){
    String jsonStr='{"name": "John Smith","email": "john@example.com"}';
    Map userMap = json.decode(jsonStr);
    var user =  _User.fromJson(userMap);

    print('Howdy, ${user.name}!');
    print('We sent the verification link to ${user.email}.');
  }
}

class _User {
  String name;
  String email;

  _User({this.name, this.email});

  //  https://www.jianshu.com/p/a0ba5f2ac5ce 构造函数
  //JSON解析工厂类，使用字典数据为对象初始化赋值 工厂构造函数，没有权利访问this
//  factory _User.fromJson(Map<String, dynamic> json) {
//    return _User(
//      name : json['name'],
//      email : json['email']
//    );
//  }

  //初始化 构造函数 主要是结合final不可变
  _User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email']{
    print('In Point.fromJson(): ($name, $email)');
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'name': name,
        'email': email,
      };


}

/// 使用json_serializable的方式创建model类



/// 使用插件生成
/*
* {
  "name": "John Smith",
  "email": "john@example.com",
  "mother":{
    "name": "Alice",
    "email":"alice@example.com"
  },
  "friends":[
    {
      "name": "Jack",
      "email":"Jack@example.com"
    },
    {
      "name": "Nancy",
      "email":"Nancy@example.com"
    }
  ]
}
*
* */

class ZQPerson {
    String email;
    List<Friend> friends;
    ZQPerson mother;
    String name;

    ZQPerson({this.email, this.friends, this.mother, this.name});

    factory ZQPerson.fromJson(Map<String, dynamic> json) {
        return ZQPerson(
            email: json['email'],
            friends: json['friends'] != null ? (json['friends'] as List).map((i) => Friend.fromJson(i)).toList() : null,
            mother: json['mother'] != null ? ZQPerson.fromJson(json['mother']) : null,
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['name'] = this.name;
        if (this.friends != null) {
            data['friends'] = this.friends.map((v) => v.toJson()).toList();
        }
        if (this.mother != null) {
            data['mother'] = this.mother.toJson();
        }
        return data;
    }
}

class Friend {
    String email;
    String name;

    Friend({this.email, this.name});

    factory Friend.fromJson(Map<String, dynamic> json) {
        return Friend(
            email: json['email'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['name'] = this.name;
        return data;
    }
}