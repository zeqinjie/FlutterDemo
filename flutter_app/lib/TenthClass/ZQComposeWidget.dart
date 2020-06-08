import 'package:flutter/material.dart';

class ZQComposeWidget extends StatefulWidget {
  ZQComposeWidget({Key key}) : super(key: key);

  @override
  _ZQComposeWidgetState createState() {
    return _ZQComposeWidgetState();
  }
}

class _ZQComposeWidgetState extends State<ZQComposeWidget> {
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
    // TODO: implement build
    return getGradientButton();
  }

  Widget getGradientButton(){
    return Container(
      child: Column(
        children: <Widget>[
          ZQGradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            child: Text("Submit"),
            onPressed: onTap,
          ),
          ZQGradientButton(
            height: 50.0,
            colors: [Colors.lightGreen, Colors.green[700]],
            child: Text("Submit"),
            onPressed: onTap,
          ),
          ZQGradientButton(
            height: 50.0,
            colors: [Colors.lightBlue[300], Colors.blueAccent],
            child: Text("Submit"),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  onTap() {
    print("button click");
  }
}
/*
* 我们DecoratedBox可以支持背景色渐变和圆角，InkWell在手指按下有涟漪效果，所以我们可以通过组合DecoratedBox和InkWell来实现GradientButton，代码如下：
* */
class ZQGradientButton extends StatelessWidget {

  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  //点击回调
  final GestureTapCallback onPressed;


  ZQGradientButton({this.colors,
                    this.width = 100,
                    this.height = 50,
                    this.borderRadius,
                    this.onPressed,
    @required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getDecoratedBoxWidget(context);
  }

  Widget getDecoratedBoxWidget(BuildContext context){
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: borderRadius,
      ),
      child: Material(//创建透明层
        type: MaterialType.transparency,//透明类型
        child: InkWell(
          splashColor: colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),//InkWell有的叫溅墨效果，有的叫水波纹效果
      ),
    );
  }
  
}