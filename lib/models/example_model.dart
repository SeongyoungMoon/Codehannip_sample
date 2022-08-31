class ExampleModel implements Comparable<ExampleModel> {
  String title;
  String description;

  ///Level1을 제외하곤 content 사용
  Map cards;

  //Todo: problem이 없는 경우 처리하려면?
  List<String> problem;

  ///이전
//  List<String> choices;

  List<Map> choices;
  String answer;
  int level;
  String hint;

  ExampleModel(
      {this.title,
      this.description,
      this.cards,
      this.problem,
      this.choices,
      this.answer,
      this.level,
      this.hint});

  factory ExampleModel.fromDs(dynamic ds, documentId) {
    return ExampleModel(
        title: ds['title'],
        description: ds['description'],
        cards: ds['cards'],
        problem: List<String>.from(ds['problem']),
        choices: List<Map>.from(ds['choices']),
        answer: ds['answer'],
        level: ds['level'],
        hint: ds['hint']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'cards': cards,
      'problem': problem,
      'choices': choices,
      'answer': answer,
      'level': level,
      'hint': hint,
    };
  }

  @override
  int compareTo(ExampleModel other) {
    return level - other.level;
  }
}
