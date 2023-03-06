import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:checkmark/checkmark.dart';

class successful extends StatefulWidget {
  const successful({Key? key}) : super(key: key);

  @override
  State<successful> createState() => _successfulState();
}

class _successfulState extends State<successful> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      height:double.infinity,
      color:Colors.white,
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          SizedBox(height:MediaQuery.of(context).size.height*0.3,),
          SizedBox(
            height: 50,
            width: 50,
            child: CheckMark(
              active:true,
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 500),
            ),
          ),
        ],
      ),
    );
  }
}
