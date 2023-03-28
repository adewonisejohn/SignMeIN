const express = require("express");
const app = express();
var student_request = require("./routes/student-request");
const bodyParser=require("body-parser");
const mongoose = require('mongoose');
const { urlencoded } = require("body-parser");
require('dotenv').config()


mongoose.connect(process.env.DATABASE_URL,{ useNewUrlParser:true})
mongoose.set('strictQuery', false)

require('dotenv').config()


const db = mongoose.connection;

db.on('error',(error)=>console.error(error))

db.once('open',()=>console.log("connected to database"))


app.use(express.json())
app.use(bodyParser.urlencoded({extended:true}));

var port = process.env.port;


app.get("/",(req,res)=>{
    console.log("the first request entered");
    res.send('seen');
});

app.post("/",(req,res)=>{
    console.log("post request sample received")
    console.log(req.body)
    res.send(req.body)
})

app.use("/student",student_request);

app.listen(port,()=>{
    console.log("server started at port : "+port);
});