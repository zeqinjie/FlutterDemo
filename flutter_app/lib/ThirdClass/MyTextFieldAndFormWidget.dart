import 'package:flutter/material.dart';
//https://book.flutterchina.club/chapter3/input_and_form.html
class MyTextFieldAndFormWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyTextFieldAndFormWidgetState();
}


class MyTextFieldAndFormWidgetState extends State {

  /*
  * focusNode：用于控制TextField是否占有当前键盘的输入焦点。它是我们和键盘交互的一个句柄（handle）。
  * InputDecoration：用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
  * keyboardType：用于设置该输入框默认的键盘输入类型，取值如下：
  *inputFormatters：用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验。
  * enable：如果为false，则输入框会被禁用，禁用状态不接收输入和事件，同时显示禁用态样式（在其decoration中定义）。
  * cursorWidth、cursorRadius和cursorColor：这三个属性是用于自定义输入框光标宽度、圆角和颜色的。
  * autofocus: 是否自动获取焦点。
  * obscureText：是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。
  * maxLines：输入框的最大行数，默认为1；如果为null，则无行数限制。
  * maxLength和maxLengthEnforced ：maxLength代表输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数。
    maxLengthEnforced决定当输入文本长度超过maxLength时是否阻止输入，为true时会阻止输入，为false时不会阻止输入但输入框会变红。
  * *****************
  * controller：编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件。
    大多数情况下我们都需要显式提供一个controller来与文本框交互。如果没有提供controller，则TextField内部会自动创建一个。
  * onChange：输入框内容改变时的回调函数；注：内容改变事件也可以通过controller来监听。
  * onEditingComplete和onSubmitted：这两个回调都是在输入框输入完成时触发，比如按了键盘的完成键（对号图标）或搜索键（🔍图标）。不同的是两个回调签名不同，
    onSubmitted回调是ValueChanged<String>类型，它接收当前输入内容做为参数，而onEditingComplete不接收参数。
  *
  *
  * */

  TextEditingController _unameController = TextEditingController();
  //设置焦点，
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  /*
  * 转移焦点，FocusScopeNode在输入框之间移动焦点、设置默认焦点等。
  * 我们可以通过FocusScope.of(context) 来获取Widget树中默认的FocusScopeNode
  * */
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _unameController = TextEditingController();
    //监听输入改变
    _unameController.addListener((){
      print("输出name:"+_unameController.text);
    });

    //设置默认值，并从第三个字符开始选中后面的字符
    _unameController.text="hello world!";
    _unameController.selection=TextSelection(
        baseOffset: 2,
        extentOffset: _unameController.text.length
    );

    //监听焦点状态改变事件,FocusNode继承自ChangeNotifier，通过FocusNode可以监听焦点的改变事件
    focusNode1.addListener((){
      print(focusNode1.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getTextFieldContainer() ;
  }

  //控制焦点

  //Private Method
  Widget getTextField() {
    //通过自定义主题来设置默认输入框的样式
    return Theme(
        data: Theme.of(context).copyWith(
            hintColor: Colors.grey[200], //定义下划线颜色
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.orange),//定义label字体样式
                hintStyle: TextStyle(color: Colors.orange, fontSize: 14.0)//定义提示文本样式
            )
        ),
        child: getTextFieldColumn(),
    );
  }

  Widget getTextFieldColumn(){
    return Column(
      children: <Widget>[
        TextField(
          controller: _unameController,
          style: TextStyle(color: Colors.yellow),
          focusNode: focusNode1,//关联focusNode1
          autofocus: true,
          textInputAction: TextInputAction.continueAction,
          decoration: InputDecoration(
            labelText: "用户名",
            labelStyle: TextStyle(color: Colors.green),
            hintText: "用户名或邮箱",
            hintStyle: TextStyle(color: Colors.red, fontSize: 13.0),
            prefixIcon: Icon(Icons.person),

          ),
        ),
        TextField(
          focusNode: focusNode2,//关联focusNode2
          onChanged: (txt){
            print("输出的密码是： $txt");
          },
          decoration: InputDecoration(
            labelText: "密码",
            hintText: "您的登录密码",
            prefixIcon: Icon(Icons.lock),
            // 未获得焦点下划线设为灰色
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            //获得焦点下划线设为蓝色
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          obscureText: true,
        ),
        OutlineButton(textColor: Colors.blue,child: Text("移动焦点"),onPressed: (){
          //将焦点从第一个TextField移到第二个TextField
          // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);

          // 这是第二种写法
          if(null == focusScopeNode) {
            focusScopeNode = FocusScope.of(context);
          }
          if (focusScopeNode.focusedChild == focusNode2) {
            focusScopeNode.requestFocus(focusNode1);
          }else{
            focusScopeNode.requestFocus(focusNode2);
          }

        },),
        OutlineButton(textColor: Colors.red,child: Text("取消焦点"),onPressed: (){
          // 当所有编辑框都失去焦点时键盘就会收起
          focusNode1.unfocus();
          focusNode2.unfocus();
        },),
      ],
    );
  }

  //隐藏掉TextField本身的下划线，然后通过Container去嵌套定义样式
  Widget getTextFieldContainer() {
    return Container(
      child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "Email",
              hintText: "电子邮件地址",
              prefixIcon: Icon(Icons.email),
              border: InputBorder.none //隐藏下划线
          )
      ),
      decoration: BoxDecoration(
        // 下滑线浅灰色，宽度1像素
          border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
      ),
    );
  }
}