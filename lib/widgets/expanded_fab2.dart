import 'package:flutter/material.dart';

class ExtendedFAB2 extends StatelessWidget {
  final IconData icon;
  final String title;
  final Future<void> Function() function;
  final double bottomPadding;

  const ExtendedFAB2({Key key,
    this.icon, this.title, this.function, this.bottomPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 18.0),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: function,
            icon: icon != null ? Icon(
                icon,
                color: Theme.of(context).colorScheme.onBackground
            ) : null,
            label: Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
    );
  }
}
