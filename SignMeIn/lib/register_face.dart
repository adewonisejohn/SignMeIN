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



class register_face extends StatefulWidget {
  const register_face({Key? key}) : super(key: key);

  @override
  State<register_face> createState() => _register_faceState();
}

class _register_faceState extends State<register_face> {
    bool is_camera=true;

    bool flash_on=false;

    bool is_predicting = false;

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
    }

    void startCamera() async {
      cameras = await availableCameras();

      cameraController = CameraController(
          cameras[0],
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
          }
        }
      });
    }


    Future<void> predict(var filepath) async{
      print('about to be predicted');

      /* final image = img.decodeImage(File(filepath).readAsBytesSync());

    final resizedImage = img.copyResize(image! , width:224, height:224);
    File(filepath).writeAsBytesSync(img.encodePng(resizedImage));*/


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
                  Align(
                    alignment:Alignment.center,
                    child:QRScannerOverlay(overlayColour:Color(0xfff4f4f4),),
                  ),

                  Align(
                    alignment:Alignment.center,
                    child:Container(
                      margin:EdgeInsets.only(top:100),
                        child: Text("No face detected",style:GoogleFonts.montserrat(color:Colors.red,fontWeight:FontWeight.w500),)),
                  ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const register_face()),
                          );
                        },
                          child:Text("Continue",style:GoogleFonts.montserrat(color:Color(0xFF252ab4),fontWeight:FontWeight.w700),),

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
