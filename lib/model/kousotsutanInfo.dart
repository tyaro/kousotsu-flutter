class kousotsutanInfos{
  List<kousotsutanInfo> cryptoInfo= [];

  /// 通貨ペアでソート
  void sortPair(bool isAscending) {
    cryptoInfo.sort((a, b) =>
        compareString(isAscending,a.pair,b.pair));
  }
  /// 判断でソート
  void sortJudgement(bool isAscending) {
    cryptoInfo.sort((a, b) =>
        compareString(isAscending,a.Judgement,b.Judgement));
  }
  /// 現在価格でソート
  void sortPrice(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.price.compareTo(b.price));
    }else{
      cryptoInfo.sort((a, b) => b.price.compareTo(a.price));
    }
  }
  /// BTC連動率でソート
  void sortBTCFRUp(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.BTCFRUp.compareTo(b.BTCFRUp));
    }else{
      cryptoInfo.sort((a, b) => b.BTCFRUp.compareTo(a.BTCFRUp));
    }
  }
  /// BTC連動率でソート
  void sortBTCFRDown(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.BTCFRDown.compareTo(b.BTCFRDown));
    }else{
      cryptoInfo.sort((a, b) => b.BTCFRDown.compareTo(a.BTCFRDown));
    }
  }
  /// オススメでソート
  void sortRecommend(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => (a.sPoint + a.lPoint).compareTo(b.sPoint + b.lPoint));
    }else{
      cryptoInfo.sort((a, b) => (b.sPoint + b.lPoint).compareTo(a.sPoint + a.lPoint));
    }
  }
  /// 適正価格乖離率でソート
  void sortDevRate(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => (a.price/a.kPrice1 - 100).compareTo(b.price/b.kPrice1 - 100));
    }else{
      cryptoInfo.sort((a, b) => (b.price/b.kPrice1 - 100).compareTo(a.price/a.kPrice1 - 100));
    }
  }
  /// 変動率でソート
  void sortChangeRate(bool isAscending) {
    if (isAscending) {
      cryptoInfo.sort((a, b) => a.ChangeRate.compareTo(b.ChangeRate));
    }else{
      cryptoInfo.sort((a, b) => b.ChangeRate.compareTo(a.ChangeRate));
    }
  }
}

class kousotsutanInfo {

  // 変数定義
  String pair; //通貨ペア
  double price; //現在価格
  double kPrice1; //適正価格
  double kPrice2; //適正価格
  double kPrice3; //適正価格
  double LEPrice; //ロングエントリー推奨価格
  double SEPrice; //ショートエントリー推奨価格
  String Trend; //2〜3日前傾向
  double DREMA200; //乖離率
  double DREMA100; //乖離率
  double DREMA50; //乖離率
  double DREMA200BTC; //乖離率
  double RSI14; //RSI14
  double BTCFRUp; //BTC連動率
  double BTCFRDown; //BTC連動率
  double ChangeRate; //変動率
  int lPoint; //
  int sPoint; //
  String Judgement;//
  String calcTime1; //計算時刻
  String calcTime; //計算時刻

  // コンストラクタ
  kousotsutanInfo({
    required this.pair,
    required this.price,
    required this.kPrice1,
    required this.kPrice2,
    required this.kPrice3,
    required this.LEPrice,
    required this.SEPrice,
    required this.Trend, //2〜3日前傾向
    required this.DREMA200, //乖離率
    required this.DREMA100, //乖離率
    required this.DREMA50, //乖離率
    required this.DREMA200BTC, //乖離率
    required this.RSI14, //RSI14
    required this.BTCFRUp, //BTC連動率
    required this.BTCFRDown, //BTC連動率
    required this.ChangeRate, //変動率
    required this.lPoint, //
    required this.sPoint, //
    required this.Judgement,//
    required this.calcTime1,
    required this.calcTime,
  });

  // JSONパース用
  factory kousotsutanInfo.fromJson(Map<String, dynamic> json){
    return kousotsutanInfo(
        pair: json['symbol'],
        price: double.parse(json['price']),
        kPrice1: double.parse(json['kousotsuPrice1']),
        kPrice2: double.parse(json['kousotsuPrice2']),
        kPrice3: double.parse(json['kousotsuPrice3']),
        LEPrice: double.parse(json['EntryPointLong']),
        SEPrice: double.parse(json['EntryPointShort']),
        Trend: json['TREND'],
        DREMA200: double.parse(json['DREMA200']),
        DREMA100: double.parse(json['DREMA100']),
        DREMA50: double.parse(json['DREMA50']),
        DREMA200BTC: double.parse(json['DREMA200BTC']),
        RSI14: double.parse(json['RSI14_1D']),
        BTCFRUp: double.parse(json['BTCFRUp']),
        BTCFRDown: double.parse(json['BTCFRDown']),
        ChangeRate: double.parse(json['ChangeRate']),
        lPoint: int.parse(json['lpoint']),
        sPoint: int.parse(json['spoint']),
        Judgement: json['Judgement'],
        calcTime1: json['calcTime1'],
        calcTime: json['calcTime']
    );
  }
}

int compareString(bool ascending, String value1, String value2) =>
    ascending ? value1.compareTo(value2) : value2.compareTo(value1);