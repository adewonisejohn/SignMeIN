
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signmein/register_face.dart';

class create extends StatefulWidget {

  create({required this.server_address});

  String server_address;

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  String full_name="";
  String gender="Gender";
  String Phone_no="";
  String email_address="";
  String matric_no="";
  String level="";
  String department="";
  String faculty="";




  List<DropdownMenuItem<String>> get dropItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Gender"),value: "Gender"),
      DropdownMenuItem(child: Text("Male"),value: "Male"),
      DropdownMenuItem(child: Text("Female"),value: "Female"),



    ];
    return menuItems;
  }
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
                          setState(() {
                            full_name=value;
                          });

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
                          setState(() {
                            matric_no=value;
                          });
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
                      /*child: TextField(
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
                          setState(() {
                            gender=value;
                          });
                        },
                      ),*/
                      child:DropdownButton(
                          value:gender,
                          onChanged: (String? newValue){
                            setState(() {
                              gender = newValue!;
                            });
                          },
                          items:dropItems
                      )
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
                          setState(() {
                            level=value;

                          });
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
                          setState(() {
                            department=value;
                          });
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
                          MaterialPageRoute(builder: (context) =>  register_face(full_name: full_name, gender: gender, Phone_no: Phone_no, email_address: email_address, matric_no: matric_no, level: level, department: department,server_address:widget.server_address,)),
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
