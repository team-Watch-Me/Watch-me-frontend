import 'package:flutter/material.dart';
class OTT {
  final String name;
  //OTT 이름
  final bool checked;
  //지금 체크했는지 여부
  //final String icon;
  //켜졌을 떄 string 경로
  //final String offIcon;
  //꺼졌을때의 경로
  final Color color;
  final bool subscribe;

  OTT.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        checked = map['checked'],
        //onIcon = map['onIcon'],
        //icon = map['icon'],
        color = map['color'],
        subscribe = map['subscribe'];
  //@override
  //String toString() => "Movie<$title:$keyword>";
}