import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:signmein/main.dart';

class login_failed extends StatefulWidget {
  login_failed({required this.address, required this.message});

  var address;
  String message;

  @override
  State<login_failed> createState() => _login_failedState();
}

class _login_failedState extends State<login_failed> {
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
                child:Icon(Icons.error_rounded,color:Colors.red,size:150)
            ),
            SizedBox(height:14,),
            Text('${widget.message.toUpperCase()}',style:GoogleFonts.montserrat(fontSize:20,fontWeight:FontWeight.w500),textAlign:TextAlign.center,),
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
                ), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>MyHomePage(title: "SignMein", server_address:widget.address)),
                );
              },
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text("Retry",style:GoogleFonts.montserrat(color:Colors.white,fontWeight:FontWeight.w700),),
                    Icon(Icons.refresh)
                  ],
                ),
              ),

            )


          ],
        ),
      ),
    );

  }
}
