import 'package:flutter/material.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  // 예시 사용자 데이터 (실제 앱에서는 사용자 데이터를 API나 DB에서 가져옴)
  String userName = "김동건";
  String userEmail = "dong_gas@gmail.com";
  String userProfileImage = "assets/icons/cat.png";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 초기 값 설정
    nameController.text = userName;
    emailController.text = userEmail;
  }

  // 정보 저장 함수 (예시: 사용자 데이터를 서버에 업데이트하는 처리)
  void _saveUserInfo() {
    setState(() {
      userName = nameController.text;
      userEmail = emailController.text;
    });

    // 여기서 서버 API 호출 등을 할 수 있습니다.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('정보가 저장되었습니다')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("내 정보"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 프로필 사진
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(userProfileImage),
              ),
            ),
            SizedBox(height: 20),

            // 사용자 이름 입력
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: '이름',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black45,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),

            // 사용자 이메일 입력
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black45,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // 사용자 정보 추가하기 (예: 전화번호, 주소 등)
            _buildInfoCard('전화번호', '010-1234-5678'),
            _buildInfoCard('주소', '서울특별시 강남구'),
            _buildInfoCard('가입 날짜', '2023년 1월 1일'),

            // 수정된 정보 저장 버튼
            Spacer(),
            ElevatedButton(
              onPressed: _saveUserInfo,
              child: Text("정보 저장"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent, // 저장 버튼 색상
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // 로그아웃 처리 (예시로 알림)
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그아웃 처리')));
              },
              child: Text("로그아웃"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // 로그아웃 버튼 색상
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 사용자 정보를 담을 카드 위젯
  Widget _buildInfoCard(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
