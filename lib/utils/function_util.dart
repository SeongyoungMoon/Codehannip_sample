//TODO: 문제별 구분자를 디비에 추가하면 하나로 통일 할 수 있을듯
Map<String, Function> functionMap = {
  '1-1': (List paramList) {
    if (paramList.where((element) => (element == null || element == '')).isNotEmpty) {
      return '값을 바르게 입력해주세요.';
    }
    final p = num.tryParse(paramList[1]);

    if (p == null) {
      return '값을 바르게 입력해주세요.';
    } else {
      return '${paramList[0]} ${paramList[1]}';
    }
  },
  '1-2': (List paramList) {
    if (paramList.where((element) => (element == null || element == '')).isNotEmpty) {
      return '값을 바르게 입력해주세요.';
    }
    final p = num.tryParse(paramList[0]);

    if (p == null) {
      return '값을 바르게 입력해주세요.';
    } else {
      var total = p;
      return '$total';
    }
  },
  '2-1': (List paramList) {
    if (paramList.where((element) => (element == null || element == '')).isNotEmpty) {
      return '값을 바르게 입력해주세요.';
    }
    final w = num.tryParse(paramList[0]);
    final g = num.tryParse(paramList[1]);

    if (w == null || g == null) {
      return '값을 바르게 입력해주세요.';
    } else {
      if (w >= 100 && g < 30) {
        return 'Sell!';
      } else {
        return 'Drop!';
      }
    }
  },
  '2-2': (List paramList) {
    if (paramList.where((element) => (element == null || element == '')).isNotEmpty) {
      return '값을 바르게 입력해주세요.';
    }
    final cra = num.tryParse(paramList[0]);
    final can = num.tryParse(paramList[1]);

    if (cra == null || can ==null) {
      return '값을 바르게 입력해주세요.';
    } else {
      if(cra < can){
        return 'Cracker!';
      }else{
        return 'Candy!';
      }
    }
  },
  '3-1': () {},
  '3-2': () {},
};
