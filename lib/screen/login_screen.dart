import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
//kakao 로그인 관련 import
import 'package:flutter/services.dart';
import 'package:watchme/screen/home_screen.dart';
//80번째 줄 platform 관련 패키지
import '../main.dart'; // MainPage가 정의된 파일을 import

void navigateToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'cea480a0279da70338ee5e2feb1bb74f',
    //cea480a0279da70338ee5e2feb1bb74f
    //앱용 key

    javaScriptAppKey: 'b507034d055ededd2172ef6658444ab4',
    //웹용 key
  );
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
              Image.asset('assets/icons/ballon.png'), // 이미지 경로 확인

              const SizedBox(height: 50), // 위젯 간의 간격 추가
              Builder(
                // 새로운 context를 제공하는 Builder 위젯 사용
                builder: (context) {
                  return TextButton(
                    onPressed: () async {
                      // 카카오 로그인 구현 예제

                      // 카카오톡 실행 가능 여부 확인
                      // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
                      if (await isKakaoTalkInstalled()) {
                        try {
                          await UserApi.instance.loginWithKakaoTalk();
                          //OAuthToken token = await UserApi.instance
                              //.loginWithKakaoAccount(prompts: [Prompt.selectAccount]);
                          /*OAuthToken token = await UserApi.instance
                              .loginWithKakaoAccount(prompts: [Prompt.login]);
                          print('로그인 성공 ${token.accessToken}');



                           */
                          User user = await UserApi.instance.me();
                          // print('사용자ID: ${user.id}');
                          // print('카카오톡으로 로그인 성공');
                        } catch (error) {
                          // print('카카오톡으로 로그인 실패 $error');

                          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                          if (error is PlatformException && error.code == 'CANCELED') {
                            return;
                          }
                          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                          try {
                            await UserApi.instance.loginWithKakaoAccount();
                            User user = await UserApi.instance.me();
                            // print('사용자ID: ${user.id}');
                            // print('카카오계정으로 로그인 성공');
                          } catch (error) {
                            // print('카카오계정으로 로그인 실패 $error');
                          }
                        }
                      } else {
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          User user = await UserApi.instance.me();
                          // print('사용자ID: ${user.id}');
                          // print('카카오계정으로 로그인 성공');
                        } catch (error) {

                          // print('카카오계정으로 로그인 실패 $error');
                        }
                      }
                      navigateToPage(context, MainPage());
                      // 로그인 이후 화면 전환은 필요에 따라 추가
                    },
                    child: Image.asset('assets/kakao_login_medium_wide.png'),
                   /* child: const Text(
                      '카카오 로그인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                   */

                  );
                },
              ),

              const SizedBox(height: 30), // 위젯 간의 간격 추가
              Builder(
                // 새로운 context를 제공하는 Builder 위젯 사용
                builder: (context) {
                  return TextButton(
                    onPressed: () async{
                      try {
                        await UserApi.instance.unlink();
                        // print('로그아웃 성공, SDK에서 토큰 삭제');
                      } catch (error) {
                        // print('로그아웃 실패, SDK에서 토큰 삭제 $error');
                      }
                      //navigateToPage(context, const MainPage());
                    },
                    child: const Text(
                      '캐시 삭제',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
