route = require("express").Router()
const bodyParser = require('body-parser');
const multer = require('multer')
const path = require("path")

route.use(bodyParser.urlencoded({ extended: true }));



var image_new_name = null

const storage = multer.diskStorage({
    destination : (req, file, cb)=>{
        cb(null,'./images')
    },

    filename: (req, file,cb)=>{
        console.log(file)
        image_new_name=Date.now()+ path.extname(file.originalname);
        cb(null,"current_image.png")
    
    }
})

const upload = multer({storage:storage})

const { spawn } = require('child_process');





route.post("/register",(req,res)=>{
    console.log(req.body);
    res.send('seend')

   
});

route.post("/login",upload.single('image'),(req,res)=>{

    var result = null;

    console.log("about to spawn python file ");

    
    var python = spawn('python3',
    [
        './python-files/main.py',
    ]
    );

    python.stdout.on('data',function(data){
        console.log(data.toString());
        result=data.toString()
    
    });

    python.on('close',function(data){
        console.log("process ended successfully");
        res.json({
            "status":"true",
            "identity":result
        
        })
    })

   

});

module.exports=route
