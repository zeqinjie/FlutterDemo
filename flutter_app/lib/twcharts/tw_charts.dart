import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class TWChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '折线图',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChartPage(),
    );
  }
}

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class SeriesDatas {
  final int time;
  final int data;

  SeriesDatas(this.time, this.data);
}

class _ChartPageState extends State<ChartPage> {
  // 折线图
  Widget _chartWidget() {
    final serial1data = [
      new SeriesDatas(1, 5),
      new SeriesDatas(2, 25),
      new SeriesDatas(3, 100),
      new SeriesDatas(4, 75),
    ];

    List<charts.Series<SeriesDatas, int>> seriesList = [
      charts.Series<SeriesDatas, int>(
        id: '',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SeriesDatas sales, _) => sales.time,
        measureFn: (SeriesDatas sales, _) => sales.data,
        data: serial1data,
      )
    ];

    var chart =  charts.LineChart(
      seriesList,
      animate: true,
      behaviors: [
        new charts.SeriesLegend(
          // 图例位置 在左侧start 和右侧end
          position: charts.BehaviorPosition.end,
          // 图例条目  [horizo​​ntalFirst]设置为false，图例条目将首先作为新行而不是新列增长
          horizontalFirst: false,
          // 每个图例条目周围的填充Padding
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // 显示度量
          showMeasures: true,
          // 度量格式
          measureFormatter: (num value) {
            return value == null ? '-' : '${value}k';
          },
        ),
      ],
    );

    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 20),
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'xxxx (折线图)',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1.0), //opacity：不透明度
                  fontFamily: 'PingFangBold',
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: SizedBox(
                height: 200.0,
                child: chart,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _chartWidget(),
      ),
    );
  }
}