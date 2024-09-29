import 'package:flutter/material.dart';
import 'package:watchme/model/model_ott.dart';

class OTTbar extends StatefulWidget {
  @override
  _OTTbarState createState() => _OTTbarState();
}

class _OTTbarState extends State<OTTbar> {
  List<OTT> ottList = [
    OTT.fromMap({
      'name': 'netflix',
      'checked': false,
      'subscribe': false,
      'onimage': 'assets/icons/netflix_on.png',  // 선택된 상태의 이미지
      'offimage': 'assets/icons/netflix_off.png', // 선택되지 않은 상태의 이미지
    }),
    OTT.fromMap({
      'name': 'tving',
      'checked': false,
      'subscribe': false,
      'onimage': 'assets/icons/tiving_on.png',  // 선택된 상태의 이미지
      'offimage': 'assets/icons/tiving_off.png', // 선택되지 않은 상태의 이미지
    }),
    OTT.fromMap({
      'name': 'coupang',
      'checked': false,
      'subscribe': false,
      'onimage': 'assets/icons/coupang_on.png',  // 선택된 상태의 이미지
      'offimage': 'assets/icons/coupang_off.png', // 선택되지 않은 상태의 이미지
    }),
    OTT.fromMap({
      'name': 'watcha',
      'checked': false,
      'subscribe': false,
      'onimage': 'assets/icons/watcha_on.png',  // 선택된 상태의 이미지
      'offimage': 'assets/icons/watcha_off.png', // 선택되지 않은 상태의 이미지
    }),
    OTT.fromMap({
      'name': 'coupang',
      'checked': false,
      'subscribe': false,
      'onimage': 'assets/icons/wave_on.png',  // 선택된 상태의 이미지
      'offimage': 'assets/icons/wave_off.png', // 선택되지 않은 상태의 이미지
    }),
  ];

  // 아이콘 버튼을 만드는 함수
  List<Widget> makeCircleIconButtons(BuildContext context, List<OTT> otts) {
    List<Widget> results = [];

    for (var i = 0; i < otts.length; i++) {
      results.add(
        GestureDetector(
          onTap: () {
            setState(() {
              otts[i].checked = !otts[i].checked; // 상태 토글
            });
          },
          child: ClipOval(
            child: Image.asset(
              otts[i].checked ? otts[i].onimage : otts[i].offimage, // 선택 여부에 따른 이미지 변경
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

      // 마지막 아이템이 아니라면, 간격을 추가
      if (i < otts.length - 1) {
        results.add(SizedBox(width: 20)); // 아이콘 간 간격을 설정 (여기서는 20px로 설정)
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: makeCircleIconButtons(context, ottList), // children에 makeCircleIconButtons 함수 적용
        ),
      ),
    );
  }
}
