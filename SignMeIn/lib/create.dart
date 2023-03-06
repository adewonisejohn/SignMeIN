
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signmein/register_face.dart';

class create extends StatefulWidget {
  const create({Key? key}) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  String full_name="";
  String gender="";
  String Phone_no="";
  String email_address="";
  String matric_no="";
  String level="";
  String department="";
  String faculty="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:double.infinity,
        padding:EdgeInsets.only(top:50,left:20,right:20),
        child:Column(
          children: [
            GestureDetector(
              onTap:(){
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back_ios_new_outlined),
                  SizedBox(width:10,),
                  Text("Register",style:GoogleFonts.montserrat(fontSize:20,fontWeight:FontWeight.w600),)
                ],
              ),
            ),
            SizedBox(height:50,),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection:Axis.vertical,
                child:Column(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment:Alignment.topLeft,
                      child:Text("Full Name:",style:GoogleFonts.montserrat(color:Colors.black,fontWeight:FontWeight.w500,fontSize:17),),
                    ),
                    Container(
                      height:45,
                      width:MediaQuery.of(context).size.width*1,
                      margin:EdgeInsets.only(bottom:20,top:10),
                      child: TextField(
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderSide: BorderSide(width: 5, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.black12),
                            ),
                            hintText: 'Full Name',
                        ),
                        keyboardType:TextInputType.name,
                        onChanged:(value){
                          print(value);
                        },
                      ),
                    ),

                    Align(
                      alignment:Alignment.topLeft,
                      child:Text("Matric Number :",style:GoogleFonts.montserrat(color:Colors.black,fontWeight:FontWeight.w500,fontSize:17),),
                    ),
                    Container(
                      height:45,
                      width:MediaQuery.of(context).size.width*1,
                      margin:EdgeInsets.only(bottom:20,top:10),
                      child: TextField(
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.black12),
                          ),
                          hintText: 'Matric Number',
                        ),
                        keyboardType:TextInputType.name,
                        onChanged:(value){
                          print(value);
                        },
                      ),
                    ),

                    Align(
                      alignment:Alignment.topLeft,
                      child:Text("Gender :",style:GoogleFonts.montserrat(color:Colors.black,fontWeight:FontWeight.w500,fontSize:17),),
                    ),
                    Container(
                      height:45,
                      width:MediaQuery.of(context).size.width*1,
                      margin:EdgeInsets.only(bottom:20,top:10),
                      child: TextField(
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.black12),
                          ),
                          hintText: 'Gender',
                        ),
                        keyboardType:TextInputType.name,
                        onChanged:(value){
                          print(value);
                        },
                      ),
                    ),

                    Align(
                      alignment:Alignment.topLeft,
                      child:Text("Level :",style:GoogleFonts.montserrat(color:Colors.black,fontWeight:FontWeight.w500,fontSize:17),),
                    ),
                    Container(
                      height:45,
                      width:MediaQuery.of(context).size.width*1,
                      margin:EdgeInsets.only(bottom:20,top:10),
                      child: TextField(
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.black12),
                          ),
                          hintText: 'Level',
                        ),
                        keyboardType:TextInputType.number,
                        onChanged:(value){
                          print(value);
                        },
                      ),
                    ),

                    Align(
                      alignment:Alignment.topLeft,
                      child:Text("Department :",style:GoogleFonts.montserrat(color:Colors.black,fontWeight:FontWeight.w500,fontSize:17),),
                    ),
                    Container(
                      height:45,
                      width:MediaQuery.of(context).size.width*1,
                      margin:EdgeInsets.only(bottom:20,top:10),
                      child: TextField(
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.black12),
                          ),
                          hintText: 'Department',
                        ),
                        keyboardType:TextInputType.text,
                        onChanged:(value){
                          print(value);
                        },
                      ),
                    ),
                    SizedBox(height:10),
                    Center(
                      child:TextButton(
                        style:TextButton.styleFrom(
                          primary: Color(0xFF252ab4),
                          foregroundColor:Color(0xFF252ab4),
                          backgroundColor:Color(0xFF252ab4),
                          maximumSize:Size(MediaQuery.of(context).size.width*0.90,MediaQuery.of(context).size.height*0.07,),
                          minimumSize:Size(MediaQuery.of(context).size.width*0.90,MediaQuery.of(context).size.height*0.07,),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Color(0xFF252ab4), width: 1)
                          ),
                        ), onPressed: () {
                        print("about to do continue to next page");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const register_face()),
                        );
                      },
                        child:Text("Continue",style:GoogleFonts.montserrat(color:Colors.white,fontWeight:FontWeight.w700),),

                      ),

                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
