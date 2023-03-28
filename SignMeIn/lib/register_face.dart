import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:camera/camera.dart';
import 'package:signmein/create.dart';
import 'package:signmein/over_lay.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:signmein/create.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'main.dart';




class register_face extends StatefulWidget {
  //const register_face({Key? key}) : super(key: key);

  register_face({required this.full_name, required this.gender, required this.Phone_no, required this.email_address, required this.matric_no ,required this.level, required this.department,required this.server_address});

  String full_name="";
  String gender="";
  String Phone_no="";
  String email_address="";
  String matric_no="";
  String level="";
  String department="";
  String server_address="";


  @override
  State<register_face> createState() => _register_faceState();
}

class _register_faceState extends State<register_face> {
    bool is_camera=true;

    bool flash_on=false;
    var address="";
    bool is_predicting = false;
    bool connection_loading=false;

    var output ;
    late List<CameraDescription> cameras;
    late CameraController cameraController;

    var _image;
    var _image_path;

    Future getImage() async{
      final image = await ImagePicker().pickImage(source:ImageSource.gallery);
      if(image==null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this._image=imageTemporary;
        this._image_path=image.path;
        is_camera=false;
      });
      Future.delayed(const Duration(milliseconds:1000), () {
        setState(() {
          //connection_loading=false;
          print("aobut to scan student face ----------------------------------------");
          register_student(this._image_path);
          print('student face scannned ---------------------------------------------');
        });

      });

    }

    void startCamera() async {
      cameras = await availableCameras();

      cameraController = CameraController(
          cameras[1],
          ResolutionPreset.high,
          enableAudio:false
      );

      await cameraController.initialize().then((value){
        if(!mounted){
          return;
        }
        setState(() {});
      }).catchError((e){
        print(e);
      });
      cameraController.setFlashMode(FlashMode.off);

    }

    void take_picture() async{
      cameraController.takePicture().then((XFile? file){
        if(mounted){
          if(file !=null ){
            print("picture saved to ${file.path}");
            final imageTemporary = File(file.path);
            setState(() {
              this._image=imageTemporary;
              this._image_path=file.path;
              is_camera=false;
            });
            Future.delayed(const Duration(milliseconds:1000), () {
              setState(() {
                //connection_loading=false;
                print("aobut to scan student face ----------------------------------------");
                register_student(this._image_path);
                print('student face scannned ---------------------------------------------');
              });

            });
          }
        }
      });
    }

    void register_student(var image) async{
      print(widget.full_name);
      print(widget.matric_no);
      print(widget.gender);
      print(widget.level);
      print(widget.department);
      setState(() {
        connection_loading=true;
      });

      try{
        final formData = FormData.fromMap(
            {
              'full_name':widget.full_name,
              'student_id' :widget.matric_no,
              'gender': widget.gender,
              'level': widget.level,
              'department' : widget.department,
              'image': await MultipartFile.fromFile(image,filename: 'current.jpg'),
            }
        );
        var response = await Dio().post(
          "http://$address/student/register",
          data:formData,options: Options(
          followRedirects: false,
          contentType: Headers.formUrlEncodedContentType,
          validateStatus: (status) { return status! < 500; },
        ),
        );
        print(response);
        var data=response.data;
        if(data["status"]==true) {
          setState(() {
            connection_loading=false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                MyHomePage(title: "SignMein", server_address: "")),
          );
        }else{
          setState(() {
            connection_loading=false;
          });
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              content: Container(
                height:MediaQuery.of(context).size.height*0.25,
                width:MediaQuery.of(context).size.width*0.05,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline_outlined,size:90,color:Colors.red),
                    SizedBox(height:5,),
                    Center(
                      child: Text("Fill in the required data",style:GoogleFonts.montserrat(fontWeight:FontWeight.w600),)
                    )
                  ],
                ),
              ),
            );
          });

        }


      }catch(e){
        print("an error occured : ${e}");
      }
    }


    @override
    void dispose(){
      cameraController.dispose();
      super.dispose();
    }




    @override
    void initState(){
      startCamera();
      address="${widget.server_address}";
      super.initState();
    }

    @override
    Widget build(BuildContext context) {

      if(cameraController.value.isInitialized){

        return Scaffold(
            body:is_predicting?Center(
                child: Container(
                  height:MediaQuery.of(context).size.height*0.15,
                  width:MediaQuery.of(context).size.width*0.15,
                  child: LoadingAnimationWidget.inkDrop(
                    color:Colors.greenAccent,
                    size:100,
                  ),
                )
            ) :
            Stack(
                children:[
                  Container(
                      width:double.infinity,
                      height:double.infinity,
                      child: is_camera ? CameraPreview(cameraController) : Container(
                        width:double.infinity,
                        color:Colors.transparent,
                        height:double.infinity,
                        child:Image.file(_image,fit:BoxFit.fitHeight),
                      )
                  ),


                  /*Align(
                    alignment:Alignment.center,
                    child:Container(
                      margin:EdgeInsets.only(top:100),
                        child: Text("No face detected",style:GoogleFonts.montserrat(color:Colors.red,fontWeight:FontWeight.w500),)),
                  ),*/
                  Align(
                    alignment:Alignment.bottomCenter,
                    child:Container(
                      height:MediaQuery.of(context).size.height*0.25,
                      padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03),
                      color:Colors.transparent,
                      child:Center(
                        child:TextButton(
                          style:TextButton.styleFrom(
                            primary: Color(0xFF252ab4),
                            foregroundColor:Color(0xFF252ab4),
                            backgroundColor:Colors.white,
                            maximumSize:Size(MediaQuery.of(context).size.width*0.90,MediaQuery.of(context).size.height*0.07,),
                            minimumSize:Size(MediaQuery.of(context).size.width*0.90,MediaQuery.of(context).size.height*0.07,),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Color(0xFF252ab4), width: 1)
                            ),
                          ), onPressed: () {
                          print("about to do continue to next page");
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => register_face(full_name: this.full_name, gender: gender, Phone_no: Phone_no, email_address: email_address, matric_no: matric_no, level: level, department: department)),
                          );*/
                          //take_picture();
                          getImage();
                          //register_student();
                        },
                          child:Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              Text("Continue",style:GoogleFonts.montserrat(color:Color(0xFF252ab4),fontWeight:FontWeight.w700),),
                              SizedBox(width:10,),
                              connection_loading?Container(
                                height:20,
                                width:20,
                                child: CircularProgressIndicator(
                                  color:Color(0xFF252ab4)
                                ),
                              ):Container()
                            ],
                          ),

                        ),

                      ),

                    ),
                    )
                ]
            )
        );


      }else{
        return const SizedBox();
      }

    }
}
