import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class roundedButton extends StatelessWidget{
  final String bName;
  final Icon? icon;
  final Color? bColor;
  final TextStyle? textStyle;
  final VoidCallback? callback;
  roundedButton({
    required this.bName,
    this.icon= const Icon(Icons.info_outline_rounded),
    this.bColor=Colors.blue,
    this.textStyle,
    this.callback,
    
});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      callback!();
    }, child:icon!=null?Row(
      children: [
        icon!,
        Container(width: 11,),
        Text(
          bName,
          style: textStyle,
        )
      ],
    )
        :Text(
      bName,
      style: textStyle,
    ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bColor,
        shadowColor:bColor,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.all(Radius.circular(21)),
        )

      ),
    );
  }

}