import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  List<Color>? colorList;
   LoadingContainer({Key? key,this.colorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20, width: 20,  decoration:  BoxDecoration(
      gradient: LinearGradient(
          colors:colorList!,
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    ),);
  }
}
