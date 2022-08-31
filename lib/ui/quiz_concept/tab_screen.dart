import 'package:code_hannip/models/column_model.dart';
import 'package:code_hannip/utils/db_string_converter.dart';
import 'package:code_hannip/widgets/flip_card.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  final ColumnModel column;

  const TabScreen({Key key, this.column,}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  TextEditingController controller;
  var realType = '';

  @override
  void initState() {
    controller = TextEditingController(text: '');
    var types = widget.column.cards.keys;
    for (var type in types) {
      if (widget.column.cards[type].length != 0) {
        realType = type;
      }
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var phoneSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 42.0, 24.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("${widget.column.cards[realType][0]} 무엇일까요?",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 28.0),
            Align(
              alignment: Alignment.center,
              child:
                Image(image: AssetImage('assets/images/category_${widget.column.category}.png')),
              // FlipCodingCard(
              //   type: realType,
              //   value: widget.column.cards[realType][0],
              // ),
            ),
            SizedBox(height: 16.0),
            Container(
              // padding: EdgeInsets.symmetric(
              //     horizontal: 24.0),
              child: Text(
                dbStringConverter('${widget.column.description}'),
                style: Theme.of(context).textTheme.headlineSmall,
//                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.0),


            // Draggable(
            //     axis: Axis.horizontal,
            //     child: Image(image: AssetImage("assets/images/6_2.png"
            //     ))),


            // Align(
            //   alignment: Alignment.center,
            //   child:
            //   Image(image:AssetImage("assets/images/6_2.png")),
            // ),

            /*
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "예시",
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            */
            /*
            Column(
                children: List.generate(widget.column.examples.length, (index) {
              List<dynamic> check = widget.column.examples['$index'];
              controller.text = check.last;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dbStringConverter(check.first),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: phoneSize.height * 0.01,
                      ),
                      check[1] == '0'
                          ? Container(
                              width: phoneSize.width * 0.9,
                              padding: EdgeInsets.all(8.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  check.last,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFC4C4C4)),
                                color: Color(0xFFC4C4C4).withOpacity(0.24),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            )
                          : TextFormField(
                              style: Theme.of(context).textTheme.bodyText1,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: '입력 값을 입력해주세요',
                                labelStyle: Theme.of(context).textTheme.caption,
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.onSecondary,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                              ),
                              controller: controller,
                            ),
                      SizedBox(
                        height: 80.0,
                      ),
                    ]),
              );
            })),*/
          ],
        ),
      ),
    );
  }
}
