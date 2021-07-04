// Jsonファイルクラス
class ChangeRateInfos {
  List<ChangeRateInfo> cryptoInfo = [];

  /// 通貨ペアでソート
  void sortPair(bool isAscending) {
    cryptoInfo.sort((a, b) =>
        compareString(isAscending,a.pair,b.pair));
  }
  /// 現在価格でソート
  void sortPrice(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.price.compareTo(b.price));
    }else{
      cryptoInfo.sort((a, b) => b.price.compareTo(a.price));
    }
  }
  /// 5分間変動率でソート
  void sortCRate05(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate05.compareTo(b.CRate05));
    }else{
      cryptoInfo.sort((a, b) => b.CRate05.compareTo(a.CRate05));
    }
  }
  /// 10分間変動率でソート
  void sortCRate10(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate10.compareTo(b.CRate10));
    }else{
      cryptoInfo.sort((a, b) => b.CRate10.compareTo(a.CRate10));
    }
  }
  /// 30分間変動率でソート
  void sortCRate30(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate30.compareTo(b.CRate30));
    }else{
      cryptoInfo.sort((a, b) => b.CRate30.compareTo(a.CRate30));
    }
  }
  /// 1時間変動率でソート
  void sortCRate60(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate60.compareTo(b.CRate60));
    }else{
      cryptoInfo.sort((a, b) => b.CRate60.compareTo(a.CRate60));
    }
  }
  /// 4時間変動率でソート
  void sortCRate240(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate240.compareTo(b.CRate240));
    }else{
      cryptoInfo.sort((a, b) => b.CRate240.compareTo(a.CRate240));
    }
  }
  /// 6時間変動率でソート
  void sortCRate360(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate360.compareTo(b.CRate360));
    }else{
      cryptoInfo.sort((a, b) => b.CRate360.compareTo(a.CRate360));
    }
  }
  /// 8時間変動率でソート
  void sortCRate480(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate480.compareTo(b.CRate480));
    }else{
      cryptoInfo.sort((a, b) => b.CRate480.compareTo(a.CRate480));
    }
  }
  /// 12時間変動率でソート
  void sortCRate720(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.CRate720.compareTo(b.CRate720));
    }else{
      cryptoInfo.sort((a, b) => b.CRate720.compareTo(a.CRate720));
    }
  }
}

// 暗号通貨情報 変動率画面用JSON定義
class ChangeRateInfo {
  // 変数定義
  String pair;  //通貨ペア
  int point;  //小数点位置
  double price; //現在価格
  double CRate05;//5分間変動率
  double CRate10;//10分間変動率
  double CRate30;//30分間変動率
  double CRate60;//60分間変動率
  double CRate240;//4時間変動率
  double CRate360;//6時間変動率
  double CRate480;//8時間変動率
  double CRate720;//12時間変動率
  String calcTime;//計算時刻

  // コンストラクタ
  ChangeRateInfo({
    required this.pair,
    required this.point,
    required this.price,
    required this.CRate05,
    required this.CRate10,
    required this.CRate30,
    required this.CRate60,
    required this.CRate240,
    required this.CRate360,
    required this.CRate480,
    required this.CRate720,
    required this.calcTime,
  });

  // JSONパース用
  factory ChangeRateInfo.fromJson(Map<String,dynamic> json){
    return ChangeRateInfo(
        pair: json['pair'],
        point: json['point'],
        price: double.parse(json['price']),
        CRate05: double.parse(json['CRate05']),
        CRate10: double.parse(json['CRate10']),
        CRate30: double.parse(json['CRate30']),
        CRate60: double.parse(json['CRate60']),
        CRate240: double.parse(json['CRate240']),
        CRate360: double.parse(json['CRate360']),
        CRate480: double.parse(json['CRate480']),
        CRate720: double.parse(json['CRate720']),
        calcTime: json['calcTime']
    );
  }

  double? getData(String colName)  {
    if (colName == 'Price'){
      return this.price;
    }else if(colName == 'CRate05'){
      return this.CRate05;
    }else if(colName == 'CRate10'){
      return this.CRate10;
    }else if(colName == 'CRate30'){
      return this.CRate30;
    }else if(colName == 'CRate60'){
      return this.CRate60;
    }else if(colName == 'CRate240'){
      return this.CRate240;
    }else if(colName == 'CRate360'){
      return this.CRate360;
    }else if(colName == 'CRate480'){
      return this.CRate480;
    }else if(colName == 'CRate720'){
      return this.CRate720;
    }
  }
}

int compareString(bool ascending, String value1, String value2) =>
    ascending ? value1.compareTo(value2) : value2.compareTo(value1);
