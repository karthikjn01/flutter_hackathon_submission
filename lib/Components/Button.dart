import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  String text;
  Color color;
  double borderRadius;
  TextStyle style;
  Function callback;

  Button(this.text, this.color, this.callback, {this.borderRadius = 8.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(text,style: Theme.of(context).textTheme.button, textAlign: TextAlign.center,  overflow: TextOverflow.clip,),
        decoration: BoxDecoration(color: this.color, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ),
    );
  }
}
