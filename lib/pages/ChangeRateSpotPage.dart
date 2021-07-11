import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../apiRequest.dart';
import '../model/ChangeRateInfo.dart';
import 'dart:async';

class ChangeRateSpotPage extends StatefulWidget {
  ChangeRateSpotPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChangeRateSpotPage> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortPair = 0;
  static const int sortPrice = 1;
  static const int sortCRate05 = 2;
  static const int sortCRate10 = 3;
  static const int sortCRate30 = 4;
  static const int sortCRate60 = 5;
  static const int sortCRate240 = 6;
  static const int sortCRate360 = 7;
  static const int sortCRate480 = 8;
  static const int sortCRate720 = 9;
  bool isAscending = true;
  int sortType = sortPair;
  int samplingTime = 10;
  ChangeRateInfos data = new ChangeRateInfos();
  var _timer;

  @override
  void initState()  {
    fetchChangeRateSpotInfo().then((value) {
      setState(() {
        data.cryptoInfo = value;
      });
    });
    super.initState();
    Timer.periodic(
      Duration(seconds: samplingTime),
      _onTimer,
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
    print("dispose");
  }

  void _onTimer(Timer timer) {
    bool isTemp = isAscending;
    int temp = sortType;
    fetchChangeRateSpotInfo().then((value) {
      if (!mounted) {return;}
      setState(() {
        data.cryptoInfo = value;
        sortType = temp;
        isAscending = isTemp;
        if(sortType == sortPair){data.sortPair(isAscending);}
        if(sortType == sortPrice){data.sortPrice(isAscending);}
        if(sortType == sortCRate05){data.sortCRate05(isAscending);}
        if(sortType == sortCRate10){data.sortCRate10(isAscending);}
        if(sortType == sortCRate30){data.sortCRate30(isAscending);}
        if(sortType == sortCRate60){data.sortCRate60(isAscending);}
        if(sortType == sortCRate240){data.sortCRate240(isAscending);}
        if(sortType == sortCRate360){data.sortCRate360(isAscending);}
        if(sortType == sortCRate480){data.sortCRate480(isAscending);}
        if(sortType == sortCRate720){data.sortCRate720(isAscending);}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 90,
        rightHandSideColumnWidth: 900,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: data.cryptoInfo.length,
        rowSeparatorWidget: const Divider(
          //color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Theme.of(context).scaffoldBackgroundColor ,
        rightHandSideColBackgroundColor: Theme.of(context).scaffoldBackgroundColor ,
        verticalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.yellow,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.red,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 60,
        onRefresh: () async {
          //Do sth
          fetchChangeRateSpotInfo().then((value) {
            setState(() {
              data.cryptoInfo = value;
            });
          });
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  // ヘッダー行 項目設定
  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '銘柄\nUSDT' + (sortType == sortPair ? (isAscending ? '↓' : '↑') : ''),
            90),
        onPressed: () {
          sortType = sortPair;
          isAscending = !isAscending;
          data.sortPair(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '現在価格' +
                (sortType == sortPrice ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortPrice;
          isAscending = !isAscending;
          data.sortPrice(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '5分間\n変動率' +
                (sortType == sortCRate05 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate05;
          isAscending = !isAscending;
          data.sortCRate05(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '10分間\n変動率' +
                (sortType == sortCRate10 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate10;
          isAscending = !isAscending;
          data.sortCRate10(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '30分間\n変動率' +
                (sortType == sortCRate30 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate30;
          isAscending = !isAscending;
          data.sortCRate30(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '1時間\n変動率' +
                (sortType == sortCRate60 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate60;
          isAscending = !isAscending;
          data.sortCRate60(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '4時間\n変動率' +
                (sortType == sortCRate240 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate240;
          isAscending = !isAscending;
          data.sortCRate240(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '6時間\n変動率' +
                (sortType == sortCRate360 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate360;
          isAscending = !isAscending;
          data.sortCRate360(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '8時間\n変動率' +
                (sortType == sortCRate480 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate480;
          isAscending = !isAscending;
          data.sortCRate480(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '12時間\n変動率' +
                (sortType == sortCRate720 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortCRate720;
          isAscending = !isAscending;
          data.sortCRate720(isAscending);
          setState(() {});
        },
      ),
    ];
  }

  // ヘッダー行書式設定
  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  // 左端固定列の設定
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(data.cryptoInfo[index].pair.replaceFirst('USDT', '')),
      width: 90,
      height: 40,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }
  // 変動率表示のテキストカラー
  // ＞0 で緑色
  // ＜0 で赤色
  Text _getPercentText(double percent){
    Color textColor = Colors.amber;
    if (percent > 0){
      textColor = Colors.green;
    }
    if (percent < 0){
      textColor = Colors.red;
    }
    return Text(
      percent.toString() + " %",
      style: TextStyle(color:textColor ),
    );
  }
  // データ列
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        // 現在価格
        Container(
          child: Row(
            children: <Widget>[
              Text("\$ " + data.cryptoInfo[index].price.toString())
            ],
          ),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 5分間変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate05),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 10分間変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate10),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 30分変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate30),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 1時間変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate60),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 4時間変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate240),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 6時間変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate360),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 8時間変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate480),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        // 12時間変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].CRate720),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}



