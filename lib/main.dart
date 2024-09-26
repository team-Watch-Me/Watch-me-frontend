import 'package:flutter/material.dart';
import 'package:watchme/screen/home_screen.dart';
import 'package:watchme/widget/bottom_bar.dart';
class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Me',
      theme: ThemeData(

        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.white,
        ),

      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              Container(
                  child: Center(
                    child: Text('search'),
                  )
              ),
              Container(
                  child: Center(
                    child: Text('save'),
                  )
              ),
              Container(
                  child: Center(
                    child: Text('more'),
                  )
              ),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}