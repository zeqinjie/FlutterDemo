import 'package:flutter/material.dart';

class MyScaffoldWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyScaffoldWidgetState();
}

//混入SingleTickerProviderStateMixin，为了传入vsync对象
class MyScaffoldWidgetState extends State<MyScaffoldWidget> with SingleTickerProviderStateMixin {
  int selectedIndex = 1;
  TabController tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    // 创建Controller 它是用于控制/监听Tab菜单切换的
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      switch(tabController.index){
        case 0: {
          print("tabController 0");
        };
        break;
        case 1: {
          print("tabController 1");
        };
        break;
        case 2: {
          print("tabController 2");
        };
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldWidget(context);
  }

  /*
  * AppBar({
      Key key,
      this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
      this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
      this.title,// 页面标题
      this.actions, // 导航栏右侧菜单
      this.bottom, // 导航栏底部菜单，通常为Tab按钮组
      this.elevation = 4.0, // 导航栏阴影
      this.centerTitle, //标题是否居中
      this.backgroundColor,
      ...   //其它属性见源码注释
  })
  * */

  Widget getScaffoldWidget(BuildContext context){
    return Scaffold(
      appBar: getAppBar(context),
      body: getTabBarView(context),
      drawer: MyDrawerWidget(),//抽屉组件
      bottomNavigationBar: getBottomAppBar(context),
      floatingActionButton: getFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//floatButton的位置
    );
  }

  //获取头部导航栏
  Widget getAppBar(BuildContext context) {
    return AppBar(
      title: Text("zhengzeqin"),
      actions: [ ////导航栏右侧菜单
        IconButton(icon: Icon(Icons.share),onPressed: (){
          print("share...");
        },),
      ],
      /*           dart  :  typedef WidgetBuilder = Widget Function(BuildContext context);
         *类似 swift block :  typealias WidgetBuilder = (BuildContext context) -> Widget;
         *      oc block  :  typedef Widget(^WidgetBuilder)(BuildContext context);
         */
      /* Scaffold添加了抽屉菜单，默认情况下Scaffold会自动将AppBar的leading设置为菜单按钮  */
      leading: Builder(builder: (context){
        return IconButton(icon: Icon(Icons.dashboard), onPressed:(){
          // 打开抽屉菜单 必须有drawer组件
          Scaffold.of(context).openDrawer();
        });
      },),
      bottom: TabBar(
        tabs:tabs.map((e) => Tab(text: e,)).toList(),
        controller: tabController,
      ),
    );
  }

  //获取TabBarView组件，通过它不仅可以轻松的实现Tab页而且可以非常容易的配合TabBar来实现同步切换和滑动状态同步
  //Material组件库也提供了一个PageView 组件，它和TabBarView功能相似
  Widget getTabBarView(BuildContext context){
    return TabBarView(
      controller: tabController,
      children:
      tabs.map((e){
        return Container(
          alignment: Alignment.center,
          child: Text(e, textScaleFactor: 5),
        );
      }).toList()
    );
  }

  //获取底部Tab导航栏tabbar
  Widget getBottomNavigationBar(BuildContext context){
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
        BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
      ],
      currentIndex: selectedIndex,
      fixedColor: Colors.blue,
      onTap: onItemTapped,
    );
  }

  //Material组件库中提供了一个BottomAppBar 组件，它可以和FloatingActionButton配合实现这种“打洞”效果，源码如下：
  Widget getBottomAppBar(BuildContext context){
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        children: [
          IconButton(icon: Icon(Icons.home)),
          SizedBox(), //中间位置空出
          IconButton(icon: Icon(Icons.business)),
        ],
      ),
    );
  }

  //
  Widget getFloatButton(){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: onClick,
      foregroundColor: Colors.yellow,
      backgroundColor: Colors.amber,
    );
  }
  /*Action*/
  //点击选中bottom item
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onClick(){

  }
}

//抽屉菜单Drawer
class MyDrawerWidget extends StatelessWidget{

  const MyDrawerWidget({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return getDrawerWidget(context);
  }

  Widget getDrawerWidget(BuildContext context){
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 64,bottom: 10),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset("assets/icons/taofang.png",width: 60,height: 60,),
                    ),
                    Text("zhengzeqin",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add account'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Manage accounts'),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
  
}