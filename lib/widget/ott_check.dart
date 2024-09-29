import 'package:flutter/material.dart';
import 'package:watchme/icons/icons.dart';
import 'package:watchme/model/model_ott.dart';

class OTTbar extends StatefulWidget {
  @override
  _OTTbarState createState() => _OTTbarState();
}

class _OTTbarState extends State<OTTbar> {
  // 아이콘의 토글 상태를 저장하는 리스트
  List<bool> isSelected = [false, false, false];
  List<OTT> ottList = [
    OTT.fromMap({
      'name': 'netflix',
      'checked':false,
      'color':Colors.red,
      'subscribe':false
    }),
    OTT.fromMap({
      'name': 'netflix',
      'checked':false,
      'color':Colors.red,
      'subscribe':false
    }),
    OTT.fromMap({
      'name': 'netflix',
      'checked':false,
      'color':Colors.red,
      'subscribe':false
    }),

  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(isSelected.length, (index) {
            return IconButton(
              icon: Icon(
                isSelected[index] ? CustomIcons.netflix : CustomIcons.netflix, // 토글에 따라 아이콘 변경
                //isSelected[index] ? Icons.star : Icons.star_border, // 토글에 따라 아이콘 변경
                color: isSelected[index] ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isSelected[index] = !isSelected[index]; // 상태 토글
                });
              },
            );
          }),
        ),


      ),
    );
  }
}

