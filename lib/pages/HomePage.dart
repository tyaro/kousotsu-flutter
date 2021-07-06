import 'package:flutter/material.dart';
import 'HighSchoolPage.dart';
import 'ChangeRatePage.dart';
import 'ChangeRateSpotPage.dart';

// アプリの枠組み
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// どのページを表示するか状態を管理
class _MyHomePageState extends State<MyHomePage>{
  // 表示中の Widget を取り出すための index としての int 型の mutable な stored property
  int _selectedIndex = 0;

  // 表示する Widget の一覧
  static List<Widget> _pageList = [
    ChangeRatePage(title: '変動率(先物)'),
    ChangeRateSpotPage(title: '変動率(現物)'),
    HighSchoolPage(title: '高卒たんメソッド'),
    CustomPage2(pannelColor: Colors.pink, title: '高卒たん改')
  ];

  // タップしたらインデックスを代入
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 下部メニューバーの設定
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
        title: const Text('Crypto Info'),
        )
      ),
      body: _pageList[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 58,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('変動率(先物)'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('変動率(現物)'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('高卒たん'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('高卒たん改'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          fixedColor: Colors.blueAccent,
          type: BottomNavigationBarType.fixed,
        ),
      )
    );
  }
}

class CustomPage1 extends StatelessWidget {
  Color pannelColor=Colors.red;
  String title="";

  CustomPage1({required this.pannelColor, required this.title});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.title;
    return Container(
      child: Center(
        child: Column(
          children: [
            Image.asset('images/img1.jpg'),
            Text('作成中です。しばらくお待ち下さい'),
            Image.asset('images/img3.png'),
          ]
        )
      ),
    );
  }
}
class CustomPage2 extends StatelessWidget {
  Color pannelColor=Colors.red;
  String title="";

  CustomPage2({required this.pannelColor, required this.title});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.title;
    return Container(
      child: Center(
          child: Column(
              children: [
                Image.asset('images/img2.jpg'),
                Text('作成中です。しばらくお待ち下さい'),
                Image.asset('images/img3.png'),
              ]
          )
      ),
    );
  }
}