import 'package:code_hannip/models/record_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RankDialog extends StatelessWidget {
  final String name;
  final int record;
  final Function onPressed;

  final List<RecordModel> rankList;

  const RankDialog(
      {Key key, this.name, this.record, this.onPressed, this.rankList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    var f = NumberFormat("00");

    return AlertDialog(
      title: Center(
        child: Text('총 ${f.format(Duration(seconds: record).inMinutes)}'
            ':${f.format(record % 60)} 걸렸어요!'),
      ),
      content: Container(
        height: phoneSize.height * 0.8,
        width: phoneSize.width * 0.7,
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int idx) {
              var result = idx < rankList.length
                  ? rankList.elementAt(idx)
                  : RecordModel.nullRecord();
              var min = Duration(seconds: result.record).inMinutes;
              var sec = result.record % 60;
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: idx<3 ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
                ),
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                /*color:
                    idx < 3 ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,*/
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        width: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: idx<3 ? Theme.of(context).colorScheme.background : Colors.transparent,
                        ),
                        child: Text(
                            "${idx + 1}",
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text("${result.name}"),
                      Text(
                        "${f.format(min)}:${f.format(sec)}",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: FlatButton(
              onPressed: onPressed ??
                  () {
                    Navigator.pop(context);
                  },
              child: Text(
                '다음으로 넘어가기',
                style: Theme.of(context).textTheme.bodySmall,
              )),
        ),
      ],
    );
  }
}
