import 'package:flutter/material.dart';
import 'package:AziApp/ytvideo.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Center (
      child: FutureBuilder<YTVideo> (
        future: fetchAziYT(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data.title,
              style: optionStyle
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
      )
    ),
    Text(
      'Index 1: Azi_SNS',
      style: optionStyle,
    ),
    Text(
      'Index 2: Azi_Info',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AziApp',
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('아지 유튜브'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('아지 SNS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('아지 정보'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[300],
        onTap: _onItemTapped,
        ),
      ),
    );
  }
}