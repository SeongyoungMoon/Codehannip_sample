import 'dart:convert';

//데이터베이스에서 가져오는 스트링 내부 '\n', '\t' 등을 화면에 그리기 위한 converter
String dbStringConverter(String dbString){
  return jsonDecode(r'{ "data":"' + dbString + r'"}')['data'];
}