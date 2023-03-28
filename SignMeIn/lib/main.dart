import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:camera/camera.dart';
import 'package:signmein/create.dart';
import 'package:signmein/dashboard.dart';
import 'package:signmein/over_lay.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:signmein/failed.dart';
import 'package:image/image.dart' as img;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:signmein/create.dart';
import 'package:signmein/successful.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:tflite/tflite.dart';
import 'dart:convert';
import 'package:signmein/successful.dart';


// ...





Future<void> main() async {
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'SignMeIn',
      home: MyHomePage(title: 'SignMeIN',server_address:"",),
      //home:create()
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({required this.title,required this.server_address});

  String title;
  String server_address;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool is_camera=true;

  bool flash_on=false;

  bool is_predicting = false;

  bool error=false;


  var address="";
  var temp_address="";

  bool connection_loading =false;

  var output ;
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  var _image;
  var _image_path;

  var is_address_valid="false";


  Future getImage() async{
    final image = await ImagePicker().pickImage(source:ImageSource.gallery);
    if(image==null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image=imageTemporary;
      this._image_path=image.path;
      is_camera=false;
      scan_student_face(this._image_path);

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
            scan_student_face(this._image_path);
          });

        }
      }
    });
  }


  void scan_student_face(var image) async{
    try{
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image,filename: 'current.jpg'),
      });
      var response = await Dio().post("http://$address/student/login",data:formData,options: Options(
          followRedirects: false,
        contentType: Headers.formUrlEncodedContentType,
        validateStatus: (status) { return status! < 500; },
      ),
      );
      var data=response.data;
      if(data["status"]==true){
        setState(() {
          connection_loading=false;
          print(data);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => successful(student_name:data["identity"][0]["full_name"])),
          );
        });
      }else{
        setState(() {
          connection_loading=false;
          print(data);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>login_failed()),
          );
        });

      }
    }catch(e){
      print("an error occured : ${e}");
    }
    /*var response = await Dio().get('http://172.20.10.4:300/student');
    print(response.data.toString());*/

  }






  @override
  void dispose(){
    cameraController.dispose();
    super.dispose();
  }




  @override
  void initState(){
    startCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(cameraController.value.isInitialized){

      return Scaffold(
          body:is_address_valid=="false"?Dialog(
            backgroundColor:Colors.white,
            child:Container(
              width:MediaQuery.of(context).size.width*0.5,
              height:MediaQuery.of(context).size.height*0.5,
              padding:EdgeInsets.only(top:50),
              child:Column(
                children: [
                  Text("Enter Attendance Address",style:GoogleFonts.montserrat(color:Colors.black,fontSize:17,fontWeight:FontWeight.w600),),
                  Container(
                    width:MediaQuery.of(context).size.width*0.55,
                    height:MediaQuery.of(context).size.height*0.07,
                    color:Colors.transparent,
                    margin:EdgeInsets.only(top:40),
                    child: TextField(
                        decoration: InputDecoration(

                          border:OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.black12),
                          ),
                            hintText: 'Enter Address'
                        ),

                      keyboardType:TextInputType.number,
                      onChanged:(value){
                          print(value);
                          setState(() {
                            address=value;
                          });
                      },
                    ),
                  ),
                  SizedBox(height:15,),
                  error?Container(
                      width:MediaQuery.of(context).size.width*0.5,color:Colors.white,
                    height:MediaQuery.of(context).size.height*0.05,
                    child:Center(
                      child:Text("Invalid address",style:GoogleFonts.montserrat(color:Colors.red),),
                    ),
                  ):Container(),
                  SizedBox(height:15,),
                  Center(
                    child:TextButton(
                      style:TextButton.styleFrom(
                        primary: Color(0xFF252ab4),
                        foregroundColor:Color(0xFF252ab4),
                        backgroundColor:Color(0xFF252ab4),
                        maximumSize:Size(MediaQuery.of(context).size.width*0.55,MediaQuery.of(context).size.height*0.07,),
                        minimumSize:Size(MediaQuery.of(context).size.width*0.40,MediaQuery.of(context).size.height*0.07,),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xFF252ab4), width: 1)
                        ),
                      ), onPressed: () async {
                        if(address.length>1){
                          setState(() {
                            connection_loading=true;
                            address=address+":6000";
                          });
                          try{
                            final dio = Dio();

                            final response = await dio.get("http://$address");
                            print(response);
                            print("server is working fine--------------------------");
                            setState(() {
                              is_address_valid="true";
                              connection_loading=false;
                              error=false;
                            });
                          }catch(e){
                            setState(() {
                              is_address_valid="false";
                              error=true;
                              connection_loading=false;
                            });
                          }
                        }
                        },
                      child:Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text("Continue",style:GoogleFonts.montserrat(color:Colors.white,fontWeight:FontWeight.w700),),
                          connection_loading?Container(
                            height:20,
                            width:20,
                            child: CircularProgressIndicator(
                              color:Colors.white,
                            ),
                          ):Container()
                        ],
                      ),
                    ),

                  ),

                ],
              )
            ),
          ):
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

                /*Container(
                  margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2),
                  child: Align(
                    alignment:Alignment.center,
                    child:Text("Position your face at the center of the ractangle",style:GoogleFonts.montserrat(color:Colors.black,fontSize:13,fontWeight:FontWeight.w600,letterSpacing: 0.1,height: 0.9),),
                  ),
                ),*/
                Align(
                  alignment:Alignment.bottomCenter,
                  child:Container(
                    height:MediaQuery.of(context).size.height*0.25,
                    padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01),
                    color:Colors.transparent,
                    child:Column(
                      children: [
                        Center(
                          child:TextButton(
                            style:TextButton.styleFrom(
                              primary: Color(0xFF252ab4),
                              foregroundColor:Color(0xFF252ab4),
                              backgroundColor:Color(0xFF252ab4),
                              maximumSize:Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.07,),
                              minimumSize:Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.07,),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xFF252ab4), width: 1)
                              ),
                            ), onPressed: () {
                            print("about to do sign in");
                            setState(() {
                              connection_loading=true;
                            });
                            //take_picture();
                            getImage();
                            //scan_student_face(_image_path);
                            /*Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const successful()),
                            );*/
                          },
                            child:Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Text("Sign in",style:GoogleFonts.montserrat(color:Colors.white,fontWeight:FontWeight.w700),),
                                SizedBox(width:10,),
                                connection_loading?Container(
                                  height:20,
                                  width:20,
                                  child: CircularProgressIndicator(
                                    color:Colors.white,
                                  ),
                                ):Container(width:0,)
                              ],
                            ),
                          ),

                        ),
                        SizedBox(height:20,),
                        Center(
                          child:TextButton(
                            style:TextButton.styleFrom(
                              primary: Color(0xFF252ab4),
                              foregroundColor:Color(0xFF252ab4),
                              backgroundColor:Colors.white,
                              maximumSize:Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.07,),
                              minimumSize:Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.07,),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xFF252ab4), width: 1)
                              ),
                            ), onPressed: () {
                            print("about to sign up");
                            take_picture();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => create(server_address:address)),
                            );
                          },
                            child:Text("Register",style:GoogleFonts.montserrat(color:Color(0xFF252ab4),fontWeight:FontWeight.w700),),
                          ),

                        )
                      ],
                    ),
                    /*child:Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap:(){
                                print("picking from photos");
                                getImage();
                                /*setState(() {
                         is_camera=false;
                       });*/
                              },
                              child: Column(
                                  children: [
                                    Container(
                                        width:60,
                                        height:60,
                                        padding:EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle
                                        ),
                                        child: Icon(Icons.photo_outlined,size:35,color:Colors.white,)
                                    ),
                                    SizedBox(height:7,),
                                    Text("Photos",style:TextStyle(
                                      color:Colors.white,
                                      fontWeight:FontWeight.bold,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1,5),
                                          blurRadius: 10.0,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                    )
                                  ]
                              ),
                            ),
                            Column(
                                children:[Container(
                                  width:70,
                                  height:70,
                                  decoration:BoxDecoration(
                                      color:Color(0xff08B118),
                                      borderRadius:BorderRadius.circular(50)
                                  ),
                                  child: Center(
                                    child: Container(
                                      width:60,
                                      height:60,
                                      decoration:BoxDecoration(
                                          color:Colors.white,
                                          borderRadius:BorderRadius.circular(50)
                                      ),
                                      child:Center(
                                        child:is_camera?GestureDetector(
                                          onTap:(){
                                            take_picture();
                                          },
                                          child: Container(
                                            width:52,
                                            height:52,
                                            decoration:BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Color(0xffc7f800),
                                                    Color(0xff078513)
                                                  ],
                                                ),
                                                ///color:Colors.black,
                                                borderRadius:BorderRadius.circular(50)
                                            ),
                                          ),
                                        ):
                                        GestureDetector(
                                          onTap:(){
                                            print("about to predict the selected image");
                                            //predict(_image_path);
                                          },
                                          child: Container(
                                            width:62,
                                            height:62,
                                            decoration:BoxDecoration(
                                                color:Colors.white,
                                                borderRadius:BorderRadius.circular(50)
                                            ),
                                            child:Icon(Icons.check,size:50,color:Color(0xff08B118)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                  SizedBox(height:7,),
                                  Text("Detect",style:TextStyle(
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1,5),
                                          blurRadius: 10.0,
                                          color: Colors.black54,
                                        ),
                                      ],
                                      color:Colors.white,
                                      fontWeight:FontWeight.bold
                                  ),)
                                ]
                            ),
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  cameraController.initialize();
                                  _image="";
                                  is_camera=true;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                      width:60,
                                      height:60,
                                      padding:EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.refresh,size:35,color:Colors.white,)
                                  ),
                                  SizedBox(height:7,),
                                  Text("Reset",style:TextStyle(shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1,5),
                                      blurRadius: 10.0,
                                      color: Colors.black54,
                                    ),
                                  ],

                                      color:Colors.white,
                                      fontWeight:FontWeight.bold
                                  )
                                  )

                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),*/
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
