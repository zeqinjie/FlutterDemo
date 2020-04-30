import 'package:flutter/material.dart';

class MyPirctureAndIconWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPirctureAndIconWidgetState();
  }
}

class MyPirctureAndIconWidgetState extends State<MyPirctureAndIconWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getPicturesWidget();
  }

  //private
  Widget getImageProviderWidget(){
    return Image(
      //在pubspec.yaml中的flutter 添加图片资源
      // 加载该图片
        image: AssetImage("assets/icons/taofang.png"),
        width: 200.0,
    );

    //提供快速获取的构造函数
    //Image.asset("assets/icons/taofang.png",
    //  width: 100.0,
    //)
  }

  Widget getNetWorkImageWidget() {
    return Image(
      image: NetworkImage(
          "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
      width: 200.0,
    );
    //提供快速获取的构造函数
    //Image.network(
    //  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
    //  width: 100.0,
    //)
  }


  //Image在显示图片时定义了一系列参数，通过这些参数我们可以控制图片的显示外观、大小、混合效果等。我们看一下Image的主要参数：
  //const Image({
  //  ...
  //  this.width, //图片的宽
  //  this.height, //图片高度
  //  this.color, //图片的混合色值
  //  this.colorBlendMode, //混合模式
  //  this.fit,//缩放模式
  //  this.alignment = Alignment.center, //对齐方式
  //  this.repeat = ImageRepeat.noRepeat, //重复方式
  //  ...
  //})
  //width、
  Widget getPicturesWidget(){
    var img=AssetImage("assets/icons/taofang.png");
    return SingleChildScrollView(
      child: Column(
          children: <Image>[
            Image(
              image: img,
              height: 50.0,
              width: 100.0,
              fit: BoxFit.fill,
            ),
            Image(
              image: img,
              height: 50,
              width: 50.0,
              fit: BoxFit.contain,
            ),
            Image(
              image: img,
              width: 100.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
            Image(
              image: img,
              width: 100.0,
              height: 50.0,
              fit: BoxFit.fitWidth,
            ),
            Image(
              image: img,
              width: 100.0,
              height: 50.0,
              fit: BoxFit.fitHeight,
            ),
            Image(
              image: img,
              width: 100.0,
              height: 50.0,
              fit: BoxFit.scaleDown,
            ),
            Image(
              image: img,
              height: 50.0,
              width: 100.0,
              fit: BoxFit.none,
            ),
            Image(
              image: img,
              width: 100.0,
              color: Colors.blue,
              colorBlendMode: BlendMode.difference,
              fit: BoxFit.fill,
            ),
            Image(
              image: img,
              width: 100.0,
              height: 200.0,
              repeat: ImageRepeat.repeatY ,
            )
          ].map((e){
            return Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 100,
                    child: e,
                  ),
                ),
                Text(e.fit.toString())
              ],
            );
          }).toList()
      ),
    );
  }
}

