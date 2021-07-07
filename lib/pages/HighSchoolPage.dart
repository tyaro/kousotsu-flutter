import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../apiRequest.dart';
import '../model/kousotsutanInfo.dart';

class HighSchoolPage extends StatefulWidget {
  HighSchoolPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HighSchoolPage> {
  HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortPair = 0;
  static const int sortJudgement = 1;
  static const int sortRecommend = 2;
  static const int sortPrice = 3;
  static const int sortkPrice1 = 4;
  static const int sortkPrice2 = 5;
  static const int sortkPrice3 = 6;
  static const int sortLEPrice = 7;
  static const int sortSEPrice = 8;
  static const int sortTrend = 9;
  static const int sortDevRate = 10;
  static const int sortDREMA200 = 11;
  static const int sortDREMA100 = 12;
  static const int sortDREMA50 = 13;
  static const int sortDREMA200BTC = 14;
  static const int sortRSI14 = 15;
  static const int sortBTCFRUp = 16;
  static const int sortBTCFRDown = 17;
  static const int sortChangeRate = 18;

  bool isAscending = true;
  int sortType = sortPair;

  kousotsutanInfos data = new kousotsutanInfos();


  @override
  void initState()  {
    super.initState();
    fetchKousotsutanInfo().then((value) {
      setState(() {
        data.cryptoInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final generalInfoAreaHeight = 50.0;
    var maxHeight = size.height - padding.top - padding.bottom - generalInfoAreaHeight - 30.0 - 58.0;
    final cryptoInfoAreaHeight = (maxHeight) * (100/100);
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _getInfoDataTableWidget(generalInfoAreaHeight),
              _getDataTableWidget(cryptoInfoAreaHeight),
            ]
        ));
  }

  // 情報エリア
  Widget _getInfoDataTableWidget(double height){
    return Container(
      color: Colors.white,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //_BTCInfoCard(height),
            _CustomInfoCard(height),
            _CustomInfoCard(height),
            _CustomInfoCard(height),
          ]),
      height: height,
    );
  }

  Widget _BTCInfoCard(double height) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: Colors.pink.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("  BTCUSDT情報",
            style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.left,
          ),
          _BTCInfo(),
        ],
      )
  );

  Widget _CustomInfoCard(double height) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Image.asset('images/img3.png',height: 42,width: 50,),
        ],
      )
  );
  // 変動率表示のテキストカラー
  // ＞0 で緑色
  // ＜0 で赤色
  Text _getPercentText2(double percent){
    Color textColor = Colors.black;
    if (percent > 0){
      textColor = Colors.green;
    }
    if (percent < 0){
      textColor = Colors.red;
    }
    return Text(
      percent.toString() + "%",
      style: TextStyle(color:textColor ),
    );
  }
  //BTC情報ウィジェット
  Widget _BTCInfo(){
    List<dynamic> list = List.of(data.cryptoInfo);
    var rows = [Text('nan'),Text('nan'),Text('nan'),Text('nan'),Text('nan'),Text('nan'),Text('nan'),Text('nan'),Text('nan')];
    if (list.length > 0) {
      final btcDataIndex = list.indexWhere((item) => item.pair == 'BTCUSDT');
      rows = [
        Text(list[btcDataIndex].price.toString()),
        Text(list[btcDataIndex].kPrice1.toString()),
        Text(list[btcDataIndex].kPrice2.toString()),
        Text(list[btcDataIndex].kPrice3.toString()),
        Text(list[btcDataIndex].LEPrice.toString()),
        Text(list[btcDataIndex].SEPrice.toString()),
        Text(list[btcDataIndex].Trend),
        _getPercentText2(list[btcDataIndex].DREMA200),
        _getPercentText2(list[btcDataIndex].DREMA100),
        _getPercentText2(list[btcDataIndex].DREMA50),
        Text(list[btcDataIndex].RSI14.toString()),
      ];
    }
    return DataTable(
        columnSpacing: 5,
        headingTextStyle: TextStyle(fontSize: 10,),
        horizontalMargin: 10,
        headingRowHeight: 12,
        dataTextStyle: TextStyle(fontSize: 13,),
        dataRowHeight: 16,
        columns: const <DataColumn>[
          DataColumn(label: Text('現在価格')),
          DataColumn(label: Text('適正価格')),
          DataColumn(label: Text('ロング')),
          DataColumn(label: Text('ショート')),
          DataColumn(label: Text('傾向')),
          DataColumn(label: Text('EMA200')),
          DataColumn(label: Text('EMA100')),
          DataColumn(label: Text('EMA50')),
          DataColumn(label: Text('RSI14')),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(rows[0]),
              DataCell(rows[1]),
              DataCell(rows[2]),
              DataCell(rows[3]),
              DataCell(rows[4]),
              DataCell(rows[5]),
              DataCell(rows[6]),
              DataCell(rows[7]),
              DataCell(rows[8]),
              DataCell(rows[9]),
            ],
          ),
        ]
    );
  }

  // データテーブル表示
  Widget _getDataTableWidget(double height) {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 90,
        rightHandSideColumnWidth: 2000,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: data.cryptoInfo.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
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
          fetchKousotsutanInfo().then((value) {
            setState(() {
              data.cryptoInfo = value;
            });
          });
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        htdRefreshController: _hdtRefreshController,
      ),
      height: height,
    );
  }

  // ヘッダー行 項目設定
  List<Widget> _getTitleWidget() {
    return [
      //通貨ペア
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
      //判断
      /*
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '判断' + (sortType == sortJudgement ? (isAscending ? '↓' : '↑') : ''),
            50),
        onPressed: () {
          sortType = sortJudgement;
          isAscending = !isAscending;
          data.sortJudgement(isAscending);
          setState(() {});
        },
      ),
       */
      //オススメ
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '評価' + (sortType == sortRecommend ? (isAscending ? '↓' : '↑') : ''),
            100),
        onPressed: () {
          sortType = sortRecommend;
          isAscending = !isAscending;
          data.sortRecommend(isAscending);
          setState(() {});
        },
      ),
      // 現在価格
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
      // 適正価格1
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '適正価格\n9時〜',
            100),
        onPressed: () {
          sortType = sortkPrice1;
          isAscending = !isAscending;
          //data.sortCRate05(isAscending);
          setState(() {});
        },
      ),
      // 適正価格2
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '適正価格\n明日\n9時〜',
            100),
        onPressed: () {
          sortType = sortkPrice2;
          isAscending = !isAscending;
          //data.sortCRate05(isAscending);
          setState(() {});
        },
      ),
      // 適正価格3
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '適正価格\n明後日\n9時〜',
            100),
        onPressed: () {
          sortType = sortkPrice3;
          isAscending = !isAscending;
          //data.sortCRate05(isAscending);
          setState(() {});
        },
      ),
      // ロングエントリ推奨価格
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'ロング\nエントリ\n推奨価格',
            100),
        onPressed: () {
          sortType = sortLEPrice;
          isAscending = !isAscending;
          //data.sortCRate05(isAscending);
          setState(() {});
        },
      ),
      // ショートエントリ推奨価格
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'ショート\nエントリ\n推奨価格',
            100),
        onPressed: () {
          sortType = sortSEPrice;
          isAscending = !isAscending;
          //data.sortCRate05(isAscending);
          setState(() {});
        },
      ),
      // 傾向
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '3~2日前\n高値安値\n推移',
            80),
        onPressed: () {
          sortType = sortTrend;
          isAscending = !isAscending;
          //data.sortCRate05(isAscending);
          setState(() {});
        },
      ),
      // 適正価格乖離率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '適正価格\n乖離率' +
                (sortType == sortDevRate ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortDevRate;
          isAscending = !isAscending;
          data.sortDevRate(isAscending);
          setState(() {});
        },
      ),
      // EMA(200)乖離率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'EMA(200)\n乖離率' +
                (sortType == sortDREMA200 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortDREMA200;
          isAscending = !isAscending;
          //data.sortDREMA200(isAscending);
          setState(() {});
        },
      ),
      // EMA(100)乖離率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'EMA(100)\n乖離率' +
                (sortType == sortDREMA100 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortDREMA100;
          isAscending = !isAscending;
          //data.sortDREMA200(isAscending);
          setState(() {});
        },
      ),
      // EMA(50)乖離率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'EMA(50)\n乖離率' +
                (sortType == sortDREMA50 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortDREMA50;
          isAscending = !isAscending;
          //data.sortDREMA200(isAscending);
          setState(() {});
        },
      ),
      // EMA(200)BTC乖離率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'BTC建て\nEMA(200)\n乖離率' +
                (sortType == sortDREMA200BTC ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortDREMA200BTC;
          isAscending = !isAscending;
          //data.sortDREMA200(isAscending);
          setState(() {});
        },
      ),
      // RSI(14)
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'RSI(14)\n日足' +
                (sortType == sortRSI14 ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortRSI14;
          isAscending = !isAscending;
          //data.sortRSI14(isAscending);
          setState(() {});
        },
      ),
      // BTC連動率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'BTC連動率\n(上昇)' +
                (sortType == sortBTCFRUp ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortBTCFRUp;
          isAscending = !isAscending;
          data.sortBTCFRUp(isAscending);
          setState(() {});
        },
      ),
      // BTC連動率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'BTC連動率\n(下落)' +
                (sortType == sortBTCFRDown ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortBTCFRDown;
          isAscending = !isAscending;
          data.sortBTCFRDown(isAscending);
          setState(() {});
        },
      ),
      // 変動率
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            '変動率\n9時〜' +
                (sortType == sortChangeRate ? (isAscending ? '↓' : '↑') : ''),
            80),
        onPressed: () {
          sortType = sortChangeRate;
          isAscending = !isAscending;
          data.sortChangeRate(isAscending);
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
      height: 74,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }
  // 左端固定列の設定
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    int lp = data.cryptoInfo[index].lPoint;
    int sp = data.cryptoInfo[index].sPoint;
    int point = lp + sp;
    Color c = Colors.white;
    if (lp > 0){
      c = Colors.lightGreen.shade50;
    }
    if (sp > 0) {
      c = Colors.pink.shade50;
    }
    return Container(
      child: Text(data.cryptoInfo[index].pair.replaceFirst('USDT', '')),
      width: 90,
      height: 40,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      color: c,
    );
  }
  // 変動率表示のテキストカラー
  // ＞0 で緑色
  // ＜0 で赤色
  Text _getPercentText(double percent){
    Color textColor = Colors.black;
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
  // 列の表示
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    int lp = data.cryptoInfo[index].lPoint;
    int sp = data.cryptoInfo[index].sPoint;
    int point = lp + sp;
    double devRate = data.cryptoInfo[index].price / data.cryptoInfo[index].kPrice1 * 100 -100;
    String rate = data.cryptoInfo[index].Judgement + " ";
    if( point > 0 ){
      for (int i = 0; i < point; i++){
        rate += '★';
      }
    }
    devRate = (devRate * 100).floor() / 100;
    Color c = Colors.white;
    if (lp > 0){
      c = Colors.lightGreen.shade50;
    }
    if (sp > 0) {
      c = Colors.pink.shade50;
    }

    return Row(
      children: <Widget>[
        // 判断
        /*
        Container(
          child: Text(data.cryptoInfo[index].Judgement),
          width: 50,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
         */
        // オススメ
        Container(
          child: Text(rate),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
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
          color: c,
        ),
        // 適正価格1
        Container(
          child: Row(
            children: <Widget>[
              Text("\$ " + data.cryptoInfo[index].kPrice1.toString())
            ],
          ),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // 適正価格2
        Container(
          child: Row(
            children: <Widget>[
              Text("\$ " + data.cryptoInfo[index].kPrice2.toString())
            ],
          ),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // 適正価格3
        Container(
          child: Row(
            children: <Widget>[
              Text("\$ " + data.cryptoInfo[index].kPrice3.toString())
            ],
          ),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // ロングエントリー推奨価格
        Container(
          child: Row(
            children: <Widget>[
              Text("\$ " + data.cryptoInfo[index].LEPrice.toString())
            ],
          ),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // ショートエントリー推奨価格
        Container(
          child: Row(
            children: <Widget>[
              Text("\$ " + data.cryptoInfo[index].SEPrice.toString())
            ],
          ),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // 傾向
        Container(
          child: Text(data.cryptoInfo[index].Trend),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // 適正価格乖離率
        Container(
          child: _getPercentText(devRate),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // EMA200乖離率
        Container(
          child: _getPercentText(data.cryptoInfo[index].DREMA200),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // EMA100乖離率
        Container(
          child: _getPercentText(data.cryptoInfo[index].DREMA100),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // EMA50乖離率
        Container(
          child: _getPercentText(data.cryptoInfo[index].DREMA50),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // BTCEMA200乖離率
        Container(
          child: _getPercentText(data.cryptoInfo[index].DREMA200BTC),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // RSI14
        Container(
          child: Text(data.cryptoInfo[index].RSI14.toString()),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // BTC連動率
        Container(
          child: Text(data.cryptoInfo[index].BTCFRUp.toString() + "%"),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // BTC連動率
        Container(
          child: Text(data.cryptoInfo[index].BTCFRDown.toString() + "%"),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),
        // 変動率
        Container(
          child: _getPercentText(data.cryptoInfo[index].ChangeRate),
          width: 80,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          color: c,
        ),

      ],
    );
  }
}



