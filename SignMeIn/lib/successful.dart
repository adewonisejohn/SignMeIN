import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:signmein/main.dart';
import 'package:checkmark/checkmark.dart';

class successful extends StatefulWidget {
  successful({required this.student_name});

  var student_name;

  @override
  State<successful> createState() => _successfulState();
}

class _successfulState extends State<successful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:double.infinity,
        height:double.infinity,
        color:Colors.white,
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            SizedBox(height:MediaQuery.of(context).size.height*0.3,),
            SizedBox(
              child:Icon(Icons.task_alt_rounded,color:Color(0xFF252ab4),size:150)
            ),
            SizedBox(height:14,),
            Text('SIGNED IN AS \n ${widget.student_name}',style:GoogleFonts.montserrat(fontSize:25,fontWeight:FontWeight.w500),textAlign:TextAlign.center,),
            SizedBox(height:5,),
            Center(
              child:TextButton(
                style:TextButton.styleFrom(
                  primary: Color(0xFF252ab4),
                  foregroundColor:Color(0xFF252ab4),
                  backgroundColor:Colors.white,
                  maximumSize:Size(MediaQuery.of(context).size.width*0.3,MediaQuery.of(context).size.height*0.05,),
                  minimumSize:Size(MediaQuery.of(context).size.width*0.3,MediaQuery.of(context).size.height*0.05,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Color(0xFF252ab4), width: 1)
                  ),
                ), onPressed: () {
              },
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Flag",style:GoogleFonts.montserrat(color:Colors.red,fontWeight:FontWeight.w700),),
                    Icon(Icons.flag,color:Colors.red)
                  ],
                ),
              ),

            ),
            SizedBox(height:5,),
            Center(
              child:TextButton(
                style:TextButton.styleFrom(
                  primary: Colors.white,
                  foregroundColor:Colors.white,
                  backgroundColor:Color(0xFF252ab4),
                  maximumSize:Size(MediaQuery.of(context).size.width*0.3,MediaQuery.of(context).size.height*0.05,),
                  minimumSize:Size(MediaQuery.of(context).size.width*0.3,MediaQuery.of(context).size.height*0.05,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Color(0xFF252ab4), width: 1)
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>MyHomePage(title: "SignMein", server_address:"")),
                  );

              },
                child:Text("Continue",style:GoogleFonts.montserrat(color:Colors.white,fontWeight:FontWeight.w700),),
              ),

            )


          ],
        ),
      ),
    );
  }
}
