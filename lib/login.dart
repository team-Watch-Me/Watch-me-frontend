import 'package:flutter/material.dart';
import 'main.dart'; // MainPage가 정의된 파일을 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color loginBackgroundColor = Colors.black87;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: loginBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로 정렬을 중앙으로
            children: <Widget>[
              Image.asset('iconTemp.png'), // 이미지 경로 확인
              const SizedBox(height: 100), // 위젯 간의 간격 추가
              Builder( // 새로운 context를 제공하는 Builder 위젯 사용
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MainPage()),
                      );
                    },
                    child: const Text(
                      '우선 로그인 없이 넘어가기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
