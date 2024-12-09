import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Container(
            height: 50,
            child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                indicatorColor: Colors.transparent,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.home,
                      size: 18,
                    ),
                    child: Text(
                      '홈',
                      style: TextStyle(fontSize: 9),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.search,
                      size: 18,
                    ),
                    child: Text(
                      '검색',
                      style: TextStyle(fontSize: 9),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.account_circle,
                      size: 18,
                    ),
                    child: Text(
                      '정보',
                      style: TextStyle(fontSize: 9),
                    ),
                  ),
                ]
            )
        )
    );
  }
}