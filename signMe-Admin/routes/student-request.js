
route = require("express").Router();
const bodyParser = require('body-parser');
const multer = require('multer');
const path = require("path");
require('dotenv').config();

const Student =  require("../models/student_register")

route.use(bodyParser.urlencoded({extended:true}));
const fs = require("fs");




var image_new_name = null

var image_new_name_register="";

var student_list=[];





const storage = multer.diskStorage({
    destination : (req, file, cb)=>{
        cb(null,'./images')
    },

    filename: (req, file,cb)=>{
        console.log(file)
        image_new_name=Date.now()+ path.extname(file.originalname);
        cb(null,"current_image.jpeg")
    
    }
})

const upload = multer({storage:storage})



const storage_register = multer.diskStorage({
    destination : (req, file, cb)=>{
        cb(null,'./database')
    },

    filename: (req, file,cb)=>{
       
        image_new_name_register=Date.now()+".jpeg";
        console.log("---------------------------------------------");
        console.log(image_new_name_register);
        console.log("-----------------------------------------------");
        cb(null,image_new_name_register)
    
    }
})

const upload_register = multer({storage:storage_register})

const { spawn } = require('child_process');
const { strict } = require("assert");


class Student_sign {
    constructor(name = "", id="", date="") {
        this.name = name;
        this.id = id;
        this.date = date;
    }
    saveAsCSV() {
        const csv = `${this.name},${this.id},${this.date}\n`;
        try {
            fs.appendFileSync("./attendance-folder/attendance_list.csv", csv);
        } catch (err) {
            console.error(err);
        }
    }
}




route.get("/",async (req,res)=>{

    try{

        var student_list= await Student.find({});
        res.send(student_list)

    }catch(e){
        console.log(e)

    }
});

route.post("/register",upload_register.single('image'),async(req,res)=>{

    console.log("student register route called")

    var python = spawn('python3',
    [
        './python-files/detect-face.py',
        image_new_name_register
    ]);
    python.stdout.on('data',async function(data){
        var result = data.toString().trim()
        if(result=="1"){
            console.log("face detected");
            const student = new Student({
                full_name : req.body.full_name,
                student_id: req.body.student_id,
                gender:req.body.gender,
                level:Number(req.body.level),
                department:req.body.department,
                face_encoding:image_new_name_register
                
            })
            try{
                console.log("about to save new student")
                const newStudent  = await student.save()
                res.status(200).json({
                    "status":true
                })
            }catch(err){
                res.status(200).json(
                    {
                        "status":false,
                        "message":""
                    }
                )
            }
        }else{
            console.log("face not detected")
            res.status(200).json(
                {
                    "status":false,
                    "message":"face not detected"
                }
            )
        }
    });

    python.on('close',function(data){
        console.log("python execution closed")
    })



    


});

async function get_student_info(face_encoding){
    var info= await Student.find({face_encoding:face_encoding});
    return info;

}

route.post("/login",upload.single('image'),async (req,res)=>{

    console.log("request made to login");

    var result = null;
    var file_path="";
    student_list= await Student.find({});
    


    try{

        for(var i=0;i<student_list.length;i++){
            var student_info={
                full_name:student_list[i].full_name,
                matric_no:student_list[i].student_id,
            }
            var python = spawn('python3',
                [
                    './python-files/compare-face.py',
                    student_list[i].face_encoding,
                    i.toString(),
                    (student_list.length-1).toString()
                ]
            );
            python.stdout.on('data',async function(data){
                try{
                    result=data.toString().trim();
                    if(result=="1"){
                        console.log('user not found')

                        res.json(
                            {
                                "status":false,
                                "message":"student not found"

                            }
                        )
                    
                    }
                    else if(result=="2"){
                        console.log("face not detected")
                        res.json(
                            {
                                "status":false,
                                "message":"Face not detected"
                            }
                        )
                    }
                    else if(result!="0" && result!="1"){
                      
                        res.status(200).json({
                            "status":true,
                            "identity":await get_student_info(result.toString())
        
                        })
                        var today = new Date();
                        var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                        var student_result = await get_student_info(result.toString())
                        const students = new Student_sign(student_result[0]["full_name"],student_result[0]["student_id"],time.toString());
                        students.saveAsCSV();
                    }else{
                        console.log("is zero ")
                    }

                }catch(eror){
                    console.error(eror)
                    console.log("an error occured")
                }
                
               
            });

            python.on('close',function(data){
                student_info.full_name="";
                student_info.matric_no=0;
            })

        }        
          

    }catch(e){
        console.log(e)

    }


   

});

module.exports=route
