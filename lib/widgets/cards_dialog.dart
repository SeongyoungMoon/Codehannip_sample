import 'package:code_hannip/widgets/coding_card.dart';
import 'package:flutter/material.dart';

class CardsDialog extends StatelessWidget {
  final Map cards;

  const CardsDialog({Key key, this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardLists = [];
    cards.entries.forEach((element) {
      for (var value in element.value) {
        cardLists.add([element.key, value]);
      }
    });
    cardLists..shuffle();
    return AlertDialog(
      title: Text('이 카드들이 필요해요'),
      content: SingleChildScrollView(
        child: Wrap(
          children: cardLists
              .map((e) => CodingCard(
                    type: e.first,
                    value: e.last,
                  ))
              .toList(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '확인',
                style: Theme.of(context).textTheme.subtitle1,
              )),
        )
      ],
    );
  }
}
