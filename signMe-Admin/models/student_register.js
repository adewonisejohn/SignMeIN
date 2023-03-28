const mongoose = require('mongoose')


const studentSchema = new mongoose.Schema({
    full_name:{
        type : String,
        required : true
    },
    student_id:{
        type : String,
        required : true
    },
    gender:{
        type : String,
        required :true
    },
    level:{
        type : Number,
        required : true
    },
    department:{
        type : String,
        required : true

    },
    face_encoding:{

        type : String,
        required : true

    }
})


module.exports=mongoose.model("Students",studentSchema)