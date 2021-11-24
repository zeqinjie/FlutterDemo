import 'package:flutter/cupertino.dart';
class ZQCupertinoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return CupertinoPageScaffold(child: Center(child: CupertinoAlertDialog(title: Text("hello"),),));
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text("Press"),
            onPressed: () {}
        ),
      ),
    );
  }

  
}