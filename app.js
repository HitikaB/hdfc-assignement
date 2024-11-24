const express = require("express");
const exphbs = require("express-handlebars");
const bodyParser= require("body-parser");

require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.urlencoded({extended:false}));  //is middleware that will process incoming requests with URL-encoded payloads. It converts the data into a JavaScript object and attaches it to req.body
app.use(bodyParser.json());

//static files
app.use(express.static("public"));


//Template Engine
const handlebars = exphbs.create({extname:".hbs"});
app.engine('hbs',handlebars.engine);
app.set("view engine","hbs");

//MYSQL connection---use this in studentcontroller.js not here
// const con= mysql.createPool({
//     connectionLimit:10,
//     host :process.env.DB_HOST,
//     user: process.env.DB_USER,
//     password:process.env.DB_PASS,
//     database:process.env.DB_NAME

// });

// //check database connection
// con.getConnection((err,connection)=>{
//     if(err) throw err
//     console.log("Connection success");
// });


//Router
// app.get('/',(req,res)=>{
//     res.render("home");
// });  --move to routes folder


//telling the express tht the student.js in server is the route file
const routes= require("./server/routes/students");
app.use('/',routes);
 


//listen port
app.listen(port,()=>{
    console.log("Listening to PORT:" +port);
});