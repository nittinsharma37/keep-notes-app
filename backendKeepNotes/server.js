const express = require("express");
const morgan = require("morgan");
// creating express app
const app = express();

//port to listen 
const port = process.env.PORT || 3500;

// imports 
const bodyParser = require("body-parser");
const connectionDb = require("./config/connectingdb");
const routes = require("./routes/routes");

//             middlewares here

//parsing requests 
app.use(bodyParser.urlencoded({extended: true}));
// parsing requests of content type application/JSON
app.use(bodyParser.json());

//using morgan for getting logs 
app.use(morgan("tiny"));

//connecting db
connectionDb();


// using a router
app.use("/", routes);

app.listen(port, ()=> {
   console.log(`Server listening on port : ${port}`);
});