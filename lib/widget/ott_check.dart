import 'package:flutter/material.dart';
import 'package:watchme/model/model_ott.dart'; // OTT 모델 임포트

class OTTbar extends StatefulWidget {
  final bool netflixSelected;
  final bool tvingSelected;
  final bool coupangSelected;
  final bool watchaSelected;
  final bool wavveSelected;
  final Function({
  required bool netflix,
  required bool tving,
  required bool coupang,
  required bool watcha,
  required bool wavve,
  }) onSelectionChanged; // 콜백 함수

  OTTbar({
    required this.netflixSelected,
    required this.tvingSelected,
    required this.coupangSelected,
    required this.watchaSelected,
    required this.wavveSelected,
    required this.onSelectionChanged,
  });

  @override
  _OTTbarState createState() => _OTTbarState();
}

class _OTTbarState extends State<OTTbar> {
  List<OTT> ottList = [];

  @override
  void initState() {
    super.initState();
    // 초기화 시 OTT 객체 리스트 만들기
    ottList = [
      OTT.fromMap({
        'name': 'netflix',
        'checked': widget.netflixSelected,
        'subscribe': false,
        'onimage': 'assets/icons/netflix_on.png',
        'offimage': 'assets/icons/netflix_off.png',
      }),
      OTT.fromMap({
        'name': 'tving',
        'checked': widget.tvingSelected,
        'subscribe': false,
        'onimage': 'assets/icons/tiving_on.png',
        'offimage': 'assets/icons/tiving_off.png',
      }),
      OTT.fromMap({
        'name': 'coupang',
        'checked': widget.coupangSelected,
        'subscribe': false,
        'onimage': 'assets/icons/coupang_on.png',
        'offimage': 'assets/icons/coupang_off.png',
      }),
      OTT.fromMap({
        'name': 'watcha',
        'checked': widget.watchaSelected,
        'subscribe': false,
        'onimage': 'assets/icons/watcha_on.png',
        'offimage': 'assets/icons/watcha_off.png',
      }),
      OTT.fromMap({
        'name': 'wavve',
        'checked': widget.wavveSelected,
        'subscribe': false,
        'onimage': 'assets/icons/wave_on.png',
        'offimage': 'assets/icons/wave_off.png',
      }),
    ];
  }

  // 아이콘을 클릭할 때마다 상태를 토글하고, 변경된 상태를 상위로 전달
  void toggleSelection(int index) {
    setState(() {
      ottList[index].checked = !ottList[index].checked; // 상태 토글
    });

    // 변경된 상태를 상위 위젯에 전달
    widget.onSelectionChanged(
      netflix: ottList[0].checked,
      tving: ottList[1].checked,
      coupang: ottList[2].checked,
      watcha: ottList[3].checked,
      wavve: ottList[4].checked,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Netflix selected: ${widget.netflixSelected}');
    print('Tving selected: ${widget.tvingSelected}');
    print('Coupang selected: ${widget.coupangSelected}');
    print('Watcha selected: ${widget.watchaSelected}');
    print('Wavve selected: ${widget.wavveSelected}');
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(ottList.length, (index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    toggleSelection(index); // 상태 토글
                  },
                  child: ClipOval(
                    child: Image.asset(
                      ottList[index].checked
                          ? ottList[index].onimage
                          : ottList[index].offimage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 마지막 아이콘을 제외하고 간격 추가
                if (index < ottList.length - 1) SizedBox(width: 15),
              ],
            );
          }),
        ),
      ),
    );
  }
}