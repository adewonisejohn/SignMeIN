import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:signmein/create.dart';
import 'package:signmein/over_lay.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:signmein/create.dart';


class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomAppBar(
        child:Container(
          width:double.infinity,
          height:MediaQuery.of(context).size.height*0.12,
          decoration:BoxDecoration(
            color:Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.bubble_chart,size:35,color:Colors.grey,),
              Icon(Icons.history,size:35,color:Color(0xFF252ab4),)
            ],
          ),
        ),
      ),
      body:Container(
        width:double.infinity,
        height:double.infinity,
        color:Colors.white,
        padding:EdgeInsets.only(top:50,left:20,right:20),
        child:Column(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment:Alignment.topLeft,
                  child:Text("HISTORY",style:GoogleFonts.montserrat(fontSize:25,fontWeight:FontWeight.w600),),
                ),
                Expanded(child:Container()),
                Icon(Icons.logout,color:Colors.red,size:25)
              ],
            )
          ],
        ),
      ),
    );
  }
}
