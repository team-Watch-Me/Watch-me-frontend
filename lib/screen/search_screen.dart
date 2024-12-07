import 'package:flutter/material.dart';
import 'package:watchme/widget/ott_check.dart';
import 'package:http/http.dart' as http;  // http 패키지 임포트
import 'package:watchme/model/model_movie.dart';
import 'package:watchme/widget/circle_slider.dart';
import 'dart:convert';  // json 관련 처리를 위한 임포트
import 'package:watchme/widget/list_slider.dart';

Future<List<Movie>> get_search_list_from_backend({
  required String searchString,
  required bool netflixSelected,
  required bool tvingSelected,
  required bool coupangSelected,
  required bool watchaSelected,
  required bool wavveSelected,
}) async {
  try {
    final Map<String, dynamic> body = {
      'searchString': searchString,
      'netflix_selected': netflixSelected,
      'tving_selected': tvingSelected,
      'coupang_selected': coupangSelected,
      'watcha_selected': watchaSelected,
      'wavve_selected': wavveSelected,
    };

    final Uri apiUrl = Uri.parse('http://3.25.85.3:8000/search_page/'); // 기본 URL

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json', // JSON 형식으로 보내기
      },
      body: json.encode(body), // 데이터를 JSON 형식으로 직렬화
    );

    print('POST 요청 URL: ${apiUrl.toString()}');  // 요청 URL 출력
    print('보낸 데이터: ${json.encode(body)}'); // 보낸 데이터 출력

    final decodedBody = utf8.decode(response.bodyBytes); // UTF-8 강제 디코딩
    print('응답 본문 (디코딩 후): $decodedBody');  // 디코딩된 응답 출력
    print('응답 헤더: ${response.headers}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(decodedBody);
      final List<dynamic> moviesList = jsonData['movies'];

      print('영화 리스트: $moviesList');

      // JSON 데이터를 Movie 객체로 변환
      moviesList.map((data) => Movie.fromJson(data['title'], data)).toList().forEach((movie) {
        print('movie 객체 출력결과');
        print(netflixSelected);
        print(watchaSelected);
        print(coupangSelected);
        print(watchaSelected);
        print(wavveSelected);
        print(movie);  // Movie 객체를 출력

      });
      return moviesList.map((data) => Movie.fromJson(data['title'], data)).toList();
    } else {
      throw Exception('영화 데이터를 가져오는 데 실패했습니다: ${response.statusCode}');
    }
  } catch (e) {
    print('HTTP 요청 중 오류 발생: $e');
    throw Exception('HTTP 요청 중 오류 발생');
  }
}

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController(); // 검색 위젯을 컨트롤 하는 위젯
  FocusNode focusNode = FocusNode(); // 검색 위젯에 커서 있는지에 대한 상태
  String _searchText = ""; // 현재 검색어
  bool netflix_selected = true;
  bool tving_selected = true;
  bool coupang_selected = true;
  bool watcha_selected = true;
  bool wavve_selected = true;

  List<Movie> searchedMovies = [];



  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Future<void> getMoviesData({
    required String searchString, // 검색어
    required List<Movie> targetList, // 업데이트할 리스트
  }) async {
    try {
      List<Movie> fetchedMovies = await get_search_list_from_backend(
        searchString: _searchText,
        netflixSelected: netflix_selected,
        tvingSelected: tving_selected,
        coupangSelected: coupang_selected,
        watchaSelected: watcha_selected,
        wavveSelected: wavve_selected,
      );
      setState(() {
        targetList.clear(); // 기존 데이터를 제거
        targetList.addAll(fetchedMovies); // 새로운 데이터 추가
      });
    } catch (e) {
      print("$searchString 데이터를 가져오는 데 실패했습니다: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    //FocusNode 상태 변경을 감지하는 리스너 추가
    focusNode.addListener(_onFocusChange);

    // focusNode를 활성화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  void _onFocusChange() {
    if(focusNode.hasFocus) {
      // focus 얻었을 땐 할 거 없음.
    }
    else {
      // focus 잃었을 때, 쿼리호출
      print("test\n");
      getMoviesData(searchString: _searchText, targetList: searchedMovies);
    }
  }

  @override
  void dispose() {
    // focusNode 해제
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10), // 전체 위젯에 동일한 여백 추가
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(32),
            ),
            OTTbar(
              // OTTbar에 상태값과 콜백 함수 전달
              netflixSelected: netflix_selected,
              tvingSelected: tving_selected,
              coupangSelected: coupang_selected,
              watchaSelected: watcha_selected,
              wavveSelected: wavve_selected,
              onSelectionChanged: ({
                required bool netflix,
                required bool tving,
                required bool coupang,
                required bool watcha,
                required bool wavve,
              }) {
                setState(() {
                  netflix_selected = netflix;
                  tving_selected = tving;
                  coupang_selected = coupang;
                  watcha_selected = watcha;
                  wavve_selected = wavve;
                });
                getMoviesData(
                  searchString: _searchText,
                  targetList: searchedMovies,
                );
              },
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      autofocus: true,
                      controller: _filter,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white12,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white60,
                          size: 20,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_searchText.isEmpty || focusNode.hasFocus)
                              IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _filter.clear();
                                    _searchText = "";
                                    //focusNode.unfocus;
                                    FocusScope.of(context).requestFocus(focusNode);
                                  });
                                },
                              ),
                            if (!_searchText.isEmpty || focusNode.hasFocus)
                              TextButton(
                                child: Text(
                                  '취소',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _filter.clear();
                                    _searchText = "";
                                    focusNode.unfocus();
                                  });
                                },
                              ),
                          ],
                        ),
                        hintText: _searchText.isEmpty
                            ? '검색'
                            : _searchText,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListSlider(movies: searchedMovies),
            ),
          ],
        ),
      ),
    );
  }
}