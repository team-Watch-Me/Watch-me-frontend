import 'package:flutter/material.dart';

class OTT {
  final String name;
  // OTT 이름
  bool checked;
  // 지금 체크했는지 여부
  //final Color color;
  bool subscribe;
  final String onimage;
  final String offimage;


  OTT.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        checked = map['checked'],
        //color = map['color'],
        subscribe = map['subscribe'],
        onimage = map['onimage'],
        offimage = map['offimage'];
}
