class RecordModel {
  String name;
  int record;

  RecordModel({
    this.name,
    this.record,
  });

  factory RecordModel.fromDs(dynamic ds) {
    return RecordModel(
      name: ds['name'],
      record: ds['record'],
    );
  }

  factory RecordModel.nullRecord() {
    return RecordModel(
      name: 'NONAME',
      record: 671,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'record': record,
    };
  }
}
