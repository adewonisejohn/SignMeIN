const express = require("express");
const app = express();
var student_request = require("./routes/student-request");


//app.use(express.static());
app.use(express.json());

var port = 500;


app.get("/",(req,res)=>{
    console.log("the first request entered");
    res.send('seen');
});

app.use("/student",student_request);

app.listen(port,()=>{
    console.log("server started at port : "+port);
});